locals {
  is_npn = var.cni_type == "npn"
  create_pod_subnet = var.create_pod_subnet && ! local.is_npn
  create_cp_subnet = var.create_cp_subnet
  create_worker_subnet = var.create_worker_subnet
  create_service_subnet = var.create_service_subnet
  vcn_id = var.create_vcn ? oci_core_vcn.spoke_vcn.0.id : var.vcn_id
}
