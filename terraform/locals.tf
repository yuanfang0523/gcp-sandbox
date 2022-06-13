locals {
  prefix      = "${terraform.workspace}-${var.service_name}"
  description = "Managed by Terraform. Environment: ${terraform.workspace}, Service: ${var.service_name}, Owner: ${var.owner}"
  labels = {
    terraform   = "true"
    environment = terraform.workspace
    service     = var.service_name
    owner       = var.owner
  }
}
