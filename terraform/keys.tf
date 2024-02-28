# RSA key of size 4096 bits
resource "tls_private_key" "this" {
  count     = var.public_ssh_key_path != "" ? 0 : 1
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Resource for extract ssh private key to file
# resource "local_file" "yc_pem" {
#   count    = var.private_ssh_key_path != "" ? 0 : 1
#   filename = "${path.module}/.tmp/cloudtls.pem"
#   content  = tls_private_key.this[0].private_key_pem
#   provisioner "local-exec" {
#     command = "chmod 600 ${path.module}/.tmp/cloudtls.pem"
#   }
# }
