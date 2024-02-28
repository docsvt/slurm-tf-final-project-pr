output "vm_ssh_key" {
  value     = var.public_ssh_key_path != "" ? "" : "${tls_private_key.this[0].private_key_pem}"
  sensitive = true
}

output "vm_external_ip" {
  value = yandex_compute_instance_group.this.instances[*].network_interface[0].nat_ip_address
}
output "external_alb_ip" {
  value = yandex_alb_load_balancer.this.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

