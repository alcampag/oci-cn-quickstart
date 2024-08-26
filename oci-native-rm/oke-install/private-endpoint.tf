resource "oci_resourcemanager_private_endpoint" "oke_private_endpoint" {
  compartment_id = var.pe_compartment_id
  display_name   = "oke-private-endpoint"
  subnet_id      = var.cp_subnet_id
  vcn_id         = var.oke_vcn_id
  is_used_with_configuration_source_provider = false
  nsg_id_list = [var.worker_nsg_id]
  count = local.is_cp_subnet_private ? 1 : 0
}