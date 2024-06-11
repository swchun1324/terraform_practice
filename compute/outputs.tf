#--- compute/outputs id

output "instance" {
  value = aws_instance.mtc_node[*]
}

output "instance_port" {
  value = aws_alb_target_group_attachment.mtc_tg_attach[0].port
}