# --- root/output.tf

output "load_balancer_endpoint" {
  value = module.alb.lb_endpoint
}

output "instance" {
  value = { for i in module.compute.instance : i.tags.Name => "${i.public_ip}:${module.compute.instance_port}" }
}

output "kubeconfig" {
  value     = [for i in module.compute.instance : "export KUBECONFIG=../k3s-${i.tags.Name}.yaml"]
}

output "k3s" {
  value     = [for i in module.compute.instance : "../k3s-${i.tags.Name}.yaml"][0]
}