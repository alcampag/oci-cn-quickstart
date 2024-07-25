variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "oke_image_name" {
  default = "Oracle-Linux-8.9-2024.05.29-0-OKE-1.30.1-707"
}

variable "kubernetes_version" {
  default = "v1.30.1"
}

variable "network_compartment_id" {
  default = null
}

variable "lb_subnet_private" {
  type = bool
  default = true
}