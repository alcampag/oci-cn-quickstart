variable "region" {}
variable "compartment_id" {}
variable "vcn_id" {}

variable "custom_private_view_name" {
}

variable "vcn_custom_private_zone_domain_names" {
  type = list(string)
}