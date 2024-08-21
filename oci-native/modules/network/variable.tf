variable "region" {}
variable "network_compartment_id" {}

variable "spoke_vcn_name" {
  default = "vcn-spoke-1"
}

variable "spoke_vcn_cidr_blocks" {
  type = list(string)
  default = ["10.1.0.0/16"]
}

variable "create_bastion" {
  type = bool
  default = true
}

variable "bastion_subnet_private" {
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