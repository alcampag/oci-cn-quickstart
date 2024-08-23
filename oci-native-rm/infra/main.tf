module "network" {
  source = "./modules/network"
  network_compartment_id = var.network_compartment_id
  region = var.my_region
  # VCN
  vcn_name = var.vcn_name
  vcn_cidr_blocks = var.vcn_cidr_blocks
  vcn_dns_label = var.vcn_dns_label
  # CP SUBNET
  cp_subnet_cidr = var.cp_subnet_cidr
  cp_subnet_dns_label = var.cp_subnet_dns_label
  cp_subnet_name = var.cp_subnet_name
  # SERVICE SUBNET
  service_subnet_cidr = var.service_subnet_cidr
  service_subnet_dns_label = var.service_subnet_dns_label
  service_subnet_name = var.service_subnet_name
  service_subnet_private = var.service_subnet_private
  # WORKER SUBNET
  worker_subnet_cidr = var.worker_subnet_cidr
  worker_subnet_dns_label = var.worker_subnet_dns_label
  worker_subnet_name = var.worker_subnet_name
  # POD SUBNET
  pod_subnet_cidr = var.pod_subnet_cidr
  pod_subnet_dns_label = var.pod_subnet_dns_label
  pod_subnet_name = var.pod_subnet_name
  # BASTION SUBNET
  create_bastion = var.create_bastion
  bastion_subnet_cidr = var.bastion_subnet_cidr
  bastion_subnet_dns_label = var.bastion_subnet_dns_label
  bastion_subnet_name = var.bastion_subnet_name
  bastion_subnet_private = var.bastion_subnet_private
}

module "bastion" {
  source = "./modules/bastion"
  region = var.my_region
  compartment_id = var.bastion_compartment_id
  vcn_name = var.vcn_name
  bastion_subnet_id = module.network.bastion_subnet_id
  bastion_cidr_block_allow_list = var.bastion_cidr_block_allow_list
  create_bastion = var.create_bastion
}

module "lb" {
  source = "./modules/lb"
  network_compartment_id = var.network_compartment_id
  region = var.my_region
  subnet_id = module.network.service_subnet_id
  lb_nsg_id = module.network.lb_nsg_id
  lb_name = var.lb_name
  lb_max_bandwidth = var.lb_max_bandwidth
  lb_min_bandwidth = var.lb_min_bandwidth
  is_private = var.service_subnet_private
  create_lb_http_redirect_rule = var.create_lb_http_redirect_rule
  create_waa = var.create_waa
}

module "dns" {
  source = "./modules/dns"
  region = var.my_region
  compartment_id = var.network_compartment_id
  vcn_id = module.network.vcn_id
  custom_private_view_name = var.custom_private_view_name
  vcn_custom_private_zone_domain_names = var.vcn_custom_private_zone_domain_names
}

module "vault" {
  source = "./modules/vault"
  region = var.my_region
  compartment_id = var.vault_compartment_id
  vault_name = var.vault_name
}


# As a Certificate can't be deleted immediately, so the CAs can't be deleted until the certificate has been fully deleted...
module "certificate" {
  source = "./modules/certificate"
  region = var.my_region
  compartment_id = var.certificate_compartment_id
  cluster_ca_key_id = module.vault.cluster_ca_key_id
  np_ca_key_id = module.vault.np_ca_key_id
  root_ca_key_id = module.vault.root_ca_key_id
  cluster_ca_subject_common_name = var.cluster_ca_subject_common_name
  lb_certificate_subject_common_name = var.lb_certificate_subject_common_name
  apigw_certificate_subject_common_name = var.apigw_certificate_subject_common_name
  np_ca_subject_common_name = var.np_ca_subject_common_name
  root_ca_subject_common_name = var.root_ca_subject_common_name
  oke_lb_certificate_name = var.oke_lb_certificate_name
  apigw_certificate_name = var.apigw_certificate_name
}

module "apigw" {
  source = "./modules/apigw"
  region = var.my_region
  network_compartment_id = var.network_compartment_id
  apigw_nsg_id = module.network.apigw_nsg_id
  subnet_id = module.network.service_subnet_id
  apigw_private = var.service_subnet_private
  create_example_deployment = false
  apigw_name = var.apigw_name
  example_deployment_hostname = "oke.example.com"
  apigw_certificate_id = module.certificate.apigw_certificate_id
  apigw_certificate_authority_id = module.certificate.np_ca_id
}