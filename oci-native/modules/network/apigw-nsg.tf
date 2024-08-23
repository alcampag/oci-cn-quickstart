resource "oci_core_network_security_group" "apigw_nsg" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  display_name = "apigw-nsg"
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_lb_egress" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "APIGW to LBs, - stateless egress"
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_lb_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "LBs to APIGW, - stateless ingress"
}

resource "oci_core_network_security_group_security_rule" "apigw_nsg_rule_bastion_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.apigw_nsg.id
  protocol                  = "6"
  source_type = "CIDR_BLOCK"
  source = local.bastion_cidr_block
  stateless = false
  description = "Rule to allow bastions to reach the API Gateway"
}