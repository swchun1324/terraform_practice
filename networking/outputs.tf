#-> network/outputs.tf

output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}

output "db_security_group" {
  value = aws_security_group.mtc_sg["private"].id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.mtc_rds_subnetgroup.*.name
}

output "lb_security_group" {
  value = aws_security_group.mtc_sg["public"].id
}

output "lb_public_subnet" {
  value = aws_subnet.mtc_public_subnet.*.id
}