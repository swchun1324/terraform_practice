#! -- loadbalancing/variables.tf

variable "public_sg" {}
variable "public_subnets" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "lb_healty_threshold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_timeout" {}
variable "lib_interval" {}
variable "vpc_id" {}
variable "listener_protocol" {}
variable "listener_port" {}