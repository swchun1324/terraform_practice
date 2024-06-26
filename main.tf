#! -> Root main.tf

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  security_groups  = local.security_groups
  public_sn_count  = 2
  private_sn_count = 3
  max_subnets      = 20
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "8.0.32"
  db_instance_class      = "db.t3.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "mtc-db"
  skip_final_snapshot    = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = [module.networking.db_security_group]
}

module "alb" {
  source                 = "./loadbalancing"
  public_sg              = module.networking.lb_security_group
  public_subnets         = module.networking.lb_public_subnet
  vpc_id                 = module.networking.vpc_id
  tg_port                = 8000
  tg_protocol            = "HTTP"
  lb_healty_threshold    = 2
  lb_unhealthy_threshold = 2
  lb_timeout             = 3
  lib_interval           = 30
  listener_protocol      = "HTTP"
  listener_port          = 80
}

module "compute" {
  source              = "./compute"
  public_sg           = module.networking.lb_security_group
  public_subnets      = module.networking.lb_public_subnet
  instance_count      = 1
  instance_type       = "t3.micro"
  vol_size            = 10
  user_data_path      = "${path.root}/userdata.tpl"
  dbuser              = var.dbuser
  dbpassword          = var.dbpassword
  dbname              = var.dbname
  db_endpoint         = module.database.db_endpoint
  lb_target_group_arn = module.alb.lb_target_group_arn
  alb_target_port     = 8000
  key_name            = "test"   # ensure to specify the key_name
  public_key_path     = "/home/ubuntu/.ssh/test.pub" #make sure to create a ssh key before running it ssh-keygen -t rsa
  private_key_path    = "/home/ubuntu/.ssh/test" #make sure to replace the private key path before using it.
}