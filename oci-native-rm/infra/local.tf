locals {
  create_certificates = var.create_certificates && var.create_vault
  create_lb = var.create_lb && var.create_service_subnet
  create_apigw = var.create_apigw && var.create_service_subnet
}
