variable "region" {}
variable "network_compartment_id" {}
variable "subnet_id" {}
variable "lb_nsg_id" {}


variable "lb_name" {
}

variable "is_private" {
  type = bool
}

variable "lb_min_bandwidth" {
  type = number
}

variable "lb_max_bandwidth" {
  type = number
}

variable "create_lb_http_redirect_rule" {
  type = bool
}

variable "create_waa" {
  type = bool
}