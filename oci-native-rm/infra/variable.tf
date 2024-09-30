variable "tenancy_ocid" {}
variable "region" {}
variable "compartment_ocid" {}
variable "network_compartment_id" {}

variable "cni_type" {
  default = "npn"
}

# VCN
variable "create_vcn" {
  type = bool
  default = true
}

variable "vcn_id" {
  default = null
}

variable "vcn_name" {
  default = "vcn-spoke-1"
}

variable "vcn_cidr_blocks" {
  type = list(string)
  default = ["10.1.0.0/16"]
}

variable "vcn_dns_label" {
  default = "spoke1"
}

# CP SUBNET

variable "cp_subnet_cidr" {
  default = "10.1.0.0/29"
}

variable "cp_subnet_dns_label" {
  default = "cp"
}

variable "cp_subnet_name" {
  default = "cp-subnet"
}

variable "cp_subnet_private" {
  type = bool
  default = true
}

variable "create_cp_public_allow_rule" {
  type = bool
  default = true
}

# WORKER SUBNET

variable "worker_subnet_cidr" {
  default = "10.1.8.0/21"
}

variable "worker_subnet_dns_label" {
  default = "worker"
}

variable "worker_subnet_name" {
  default = "worker-subnet"
}

# POD SUBNET

variable "pod_subnet_cidr" {
  default = "10.1.128.0/18"
}

variable "pod_subnet_dns_label" {
  default = "pod"
}

variable "pod_subnet_name" {
  default = "pod-subnet"
}

# SERVICE SUBNET

variable "service_subnet_cidr" {
  default = "10.1.0.32/27"
}

variable "service_subnet_private" {
  type = bool
  default = true
}

variable "service_subnet_dns_label" {
  default = "service"
}

variable "service_subnet_name" {
  default = "service-subnet"
}

# BASTION SUBNET

variable "bastion_subnet_cidr" {
  default = "10.1.0.8/29"
}

variable "bastion_subnet_private" {
  type = bool
  default = true
}

variable "bastion_subnet_dns_label" {
  default = "bastion"
}

variable "bastion_subnet_name" {
  default = "bastion-subnet"
}

# FSS SUBNET

variable "create_fss" {
  type = bool
  default = false
}

variable "fss_subnet_cidr" {
  default = "10.1.0.64/26"
}

variable "fss_subnet_dns_label" {
  default = "fss"
}

variable "fss_subnet_name" {
  default = "fss-subnet"
}

# BASTION MODULE

variable "create_bastion" {
  type = bool
  default = true
}

variable "bastion_compartment_id" {
  default = null
}

variable "bastion_cidr_block_allow_list" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

# LB + WAA

variable "create_lb" {
  type = bool
  default = false
}

variable "lb_name" {
  default = "oke-lb"
}

variable "lb_min_bandwidth" {
  type = number
  default = 10
}

variable "lb_max_bandwidth" {
  type = number
  default = 10
}

variable "create_lb_http_redirect_rule" {
  type = bool
  default = true
}

variable "create_waa" {
  type = bool
  default = true
}

# DNS PRIVATE VIEW

variable "create_private_dns_view" {
  type = bool
  default = false
}

variable "custom_private_view_name" {
  default = "np-oci-acme-tst"
}

variable "vcn_custom_private_zone_domain_names" {
  type = list(string)
  default = ["np.oci.acme.tst"]
}

# VAULT

variable "create_vault" {
  type = bool
  default = false
}

variable "vault_compartment_id" {
  default = null
}

variable "vault_name" {
  default = "oci-vault-quickstart"
}

# CERTIFICATE

variable "create_certificates" {
  type = bool
  default = false
}

variable "certificate_compartment_id" {
  default = null
}

variable "cluster_ca_subject_common_name" {
  default = "oke-quickstart.np.oci.acme.tst"
}
variable "lb_certificate_subject_common_name" {
  default = "oke-lb.lb.oke-quickstart.np.oci.acme.tst"
}
variable "apigw_certificate_subject_common_name" {
  default = "api.oke-quickstart.np.oci.acme.tst"
}
variable "np_ca_subject_common_name" {
  default = "np.oci.acme.tst"
}
variable "root_ca_subject_common_name" {
  default = "oci.acme.tst"
}

variable "oke_lb_certificate_name" {
  default = "oke-lb-certificate"
}

variable "apigw_certificate_name" {
  default = "api-gw-certificate"
}

# APIGW

variable "create_apigw" {
  type = bool
  default = false
}

variable "apigw_name" {
  default = "oci-apigw-quickstart"
}




