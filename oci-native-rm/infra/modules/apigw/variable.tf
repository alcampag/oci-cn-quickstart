variable "network_compartment_id" {}
variable "region" {}
variable "apigw_nsg_id" {}
variable "subnet_id" {}

variable "apigw_name" {
}

variable "apigw_private" {
  type = bool
}

variable "create_example_deployment" {
  type = bool
}

variable "example_deployment_hostname" {
}

variable "apigw_certificate_id" {}

variable "apigw_certificate_authority_id" {}