variable "network_compartment_id" {}
variable "create_bastion_subnet" {
  type = bool
}
variable "cni_type" {}

variable "lb_subnet_cidr" {
  default = "10.0.0.32/27"
}

variable "lb_subnet_private" {
  type = bool
  default = false
}