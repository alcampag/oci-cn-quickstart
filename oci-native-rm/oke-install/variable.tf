variable "region" {}
variable "tenancy_ocid" {}
variable "oke_cluster_id" {}
variable "oke_cluster_compartment_id" {}
variable "pe_compartment_id" {}
variable "cp_subnet_id" {}
variable "oke_vcn_id" {}
variable "worker_nsg_id" {}
variable "home_region" {}

# Install options

## Native Ingress
variable "install_native_ingress" {
  type = bool
  default = true
}
variable "network_compartment_id" {}
variable "certificate_compartment_id" {
  default = null
}
variable "waf_compartment_id" {
  default = null
}
variable "policy_compartment_id" {
  default = null
}
variable "lb_subnet_id" {
  default = null
}

## Nginx
variable "install_nginx" {
  type = bool
  default = true
}
variable "nginx_release_name" {
  default = "nginx1"
}
variable "nginx_namespace" {
  default = "nginx"
}
variable "nginx_service_type" {
  default = "ClusterIP"
}
variable "nginx_chart_version" {
  default = null
}

variable "nginx_service_annotations" {
  default = "oci.oraclecloud.com/load-balancer-type: \"lb\""
}

## ISTIO

variable "install_istio" {
  type = bool
  default = false
}

## POLICY

variable "create_policy" {
  type = bool
  default = true
}

variable "policy_name" {
  default = "oke-policy"
}

variable "policy_description" {
  default = "Policy created to enable various tools on the OKE service"
}