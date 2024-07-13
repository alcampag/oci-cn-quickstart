resource "oci_core_subnet" "oke_lb_subnet" {
  cidr_block     = var.lb_subnet_cidr
  compartment_id = var.network_compartment_id
  vcn_id         = module.oke-network.vcn_id
  prohibit_public_ip_on_vnic = var.lb_subnet_private
}



resource "oci_load_balancer_load_balancer" "" {
  compartment_id = var.network_compartment_id
  display_name   = "oke-lb"
  shape          = "flexible"
  subnet_ids = [oci_core_subnet.oke_lb_subnet.id]
  is_private = var.lb_subnet_private
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  network_security_group_ids = []
}