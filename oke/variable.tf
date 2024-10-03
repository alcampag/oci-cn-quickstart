variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "oke_image_name" {
  default = "Oracle-Linux-8.10-2024.06.30-0-OKE-1.30.1-716"
}
variable "cni_type" {
  default = "npn"   # flannel if you need an OKE cluster with Flannel
}

variable "kubernetes_version" {
  default = "v1.30.1"
}

variable "create_bastion_subnet" {
  type = bool
  default = false
}
