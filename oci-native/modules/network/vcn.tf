resource "oci_core_vcn" "spoke_vcn" {
  compartment_id = var.network_compartment_id
  display_name = var.spoke_vcn_name
  cidr_blocks = var.spoke_vcn_cidr_blocks
  dns_label = "spoke1"
}

resource "oci_core_default_security_list" "lockdown" {
  manage_default_resource_id = oci_core_vcn.spoke_vcn.id
  count = 0
  lifecycle {
    ignore_changes = [egress_security_rules, ingress_security_rules, defined_tags]
  }
}