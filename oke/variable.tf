variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "oke_image_name" {
  default = "Oracle-Linux-8.9-2024.05.29-0-OKE-1.29.1-707"
}
variable "cni_type" {
  default = "npn"   # flannel if you need an OKE cluster with Flannel
}

variable "kubernetes_version" {
  default = "v1.29.1"
}

variable "create_bastion_subnet" {
  type = bool
  default = false
}