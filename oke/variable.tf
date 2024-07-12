variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "oke_image_name" {
  default = "Oracle-Linux-7.9-2024.05.29-0-OKE-1.29.1-707"
}
variable "cni_type" {
  default = "npn"
}

variable "kubernetes_version" {
  default = "v1.29.1"
}