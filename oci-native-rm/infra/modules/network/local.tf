locals {
  create_pod = var.cni_type == "npn"
  vcn_id = var.create_vcn ? oci_core_vcn.spoke_vcn.0.id: var.vcn_id
}
