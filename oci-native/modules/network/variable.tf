variable "region" {}
variable "network_compartment_id" {}

variable "vcn_name" {
  default = "vcn-spoke-1"
}

variable "create_bastion_subnet" {
  type = bool
  default = true
}

variable "lb_subnet_cidr" {
  default = "10.1.0.32/27"
}

variable "lb_subnet_private" {
  type = bool
  default = true
}

variable "create_lb_http_redirect_rule" {
  type = bool
  default = false
}

variable "create_lb_waa" {
  type = bool
  default = false
}

variable "apigw_private" {
  type = bool
  default = true
}