variable "region" {}
variable "network_compartment_id" {}

variable "vcn_name" {
}

variable "vcn_cidr_blocks" {
  type = list(string)
}

variable "vcn_dns_label" {
}


# CP SUBNET
variable "cp_subnet_cidr" {
}

variable "cp_subnet_dns_label" {
}

variable "cp_subnet_name" {
}

# WORKER SUBNET

variable "worker_subnet_cidr" {
}

variable "worker_subnet_dns_label" {
}

variable "worker_subnet_name" {
}

# POD SUBNET

variable "pod_subnet_cidr" {
}

variable "pod_subnet_dns_label" {
}

variable "pod_subnet_name" {
}

# SERVICE SUBNET

variable "service_subnet_cidr" {
}

variable "service_subnet_private" {
  type = bool
}

variable "service_subnet_dns_label" {
}

variable "service_subnet_name" {
}


# BASTION SUBNET

variable "create_bastion" {
  type = bool
}

variable "bastion_subnet_private" {
  type = bool
}

variable "bastion_subnet_cidr" {
}

variable "bastion_subnet_dns_label" {
}

variable "bastion_subnet_name" {
}