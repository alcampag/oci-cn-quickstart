resource "oci_core_network_security_group" "apigw_nsg" {
  compartment_id = var.network_compartment_id
  vcn_id         = local.vcn_id
  display_name = "apigw-nsg"
  count = var.create_apigw ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_lb_egress" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.0.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "APIGW to LBs, - stateless egress"
  count = var.create_apigw ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_lb_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.0.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "LBs to APIGW, - stateless ingress"
  count = var.create_apigw ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_bastion_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.0.id
  protocol                  = "6"
  source_type = "CIDR_BLOCK"
  source = var.bastion_subnet_cidr
  stateless = false
  description = "Rule to allow bastions to reach the API Gateway"
  count = var.create_apigw && var.create_bastion_subnet ? 1 : 0
}