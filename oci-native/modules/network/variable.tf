variable "network_compartment_id" {}
variable "create_bastion_subnet" {
  type = bool
  default = false
}
variable "lb_subnet_cidr" {
  default = "10.0.0.32/27"
}

variable "lb_subnet_private" {
  type = bool
  default = false
}

variable "create_lb_https_redirect_rule" {
  type = bool
  default = true
}

variable "create_lb_waa" {
  type = bool
  default = true
}