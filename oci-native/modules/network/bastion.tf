resource "oci_bastion_bastion" "vcn_spoke_bastion" {
  bastion_type     = "STANDARD"
  compartment_id   = var.network_compartment_id
  target_subnet_id = oci_core_subnet.bastion_subnet.0.id
  name = "bastion-vcn-spoke1"
  dns_proxy_status = "ENABLED"
  client_cidr_block_allow_list = ["0.0.0.0/0"]
  count = var.create_bastion ? 1 : 0
}