variable "region" {}
variable "oke_cluster_id" {}
variable "oke_cluster_compartment_id" {}
variable "pe_compartment_id" {}
variable "cp_subnet_id" {}
variable "oke_vcn_id" {}
variable "worker_nsg_id" {}

# Install options


## Native Ingress
variable "network_compartment_id" {}
variable "certificate_compartment_id" {}
variable "waf_compartment_id" {}
variable "policy_compartment_id" {}
variable "lb_subnet_id" {}

## Nginx
variable "nginx_release_name" {}
variable "nginx_namespace" {
  default = "nginx"
}
variable "nginx_service_type" {
  default = "ClusterIP"
}
variable "nginx_chart_version" {
  default = null
}