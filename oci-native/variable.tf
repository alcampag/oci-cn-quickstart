variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "oke_image_name" {
  default = "Oracle-Linux-8.9-2024.05.29-0-OKE-1.29.1-707"
}

variable "kubernetes_version" {
  default = "v1.29.1"
}

variable "create_bastion_subnet" {
  type = bool
  default = false
}

variable "network_compartment_id" {
  default = null
}

variable "lb_subnet_private" {
  type = bool
  default = true
}