#! root/local.tf

locals {
  vpc_cidr = "10.123.0.0/16"
}


locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Public Security groups"
      ingress = {
        open = {
          from        = 0
          to          = 0
          protocol    = -1
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        http_port = {
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    private = {
      name        = "rds_sg"
      description = "Security group for RDS instance"
      ingress = {
        db_port = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }

  }
}

