variable "tenancy_ocid" {}
variable "region" {}
variable "home_region" {}

# NETWORK

variable "network_compartment_id" {}
variable "cni_type" {
  default = "npn"
}
variable "vcn_id" {}
variable "lb_subnet_id" {}
variable "cp_subnet_id" {}
variable "worker_subnet_id" {}
variable "pod_subnet_id" {
  default = null
}
variable "cp_nsg_id" {}
variable "cp_allowed_cidr_list" {
  type = list(string)
  default = ["0.0.0.0/0"]
}


# CLUSTER

variable "oke_compartment_id" {}
variable "cluster_name" {
  default = "oke-rm-quickstart"
}
variable "kubernetes_version" {}

variable "cluster_type" {
  default = "enhanced"
}

variable "services_cidr" {
  default = "10.96.0.0/16"
}

variable "pods_cidr" {
  default = "10.244.0.0/16"
}