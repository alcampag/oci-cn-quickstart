resource "oci_core_subnet" "service_subnet" {
  cidr_block     = var.lb_subnet_cidr
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  prohibit_public_ip_on_vnic = var.lb_subnet_private
  dns_label = "service"
  display_name = "network-service-subnet"
  route_table_id = var.lb_subnet_private ? oci_core_route_table.service_route_table.id : oci_core_route_table.internet_route_table[0].id
}

resource "oci_core_subnet" "oke_cp_subnet" {
  cidr_block     = "10.1.0.0/29"
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  dns_label = "cp"
  display_name = "oke-cp-subnet"
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.service_route_table.id
}

resource "oci_core_subnet" "worker_subnet" {
  cidr_block     = "10.1.8.0/21"
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  dns_label = "worker"
  display_name = "worker-subnet"
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.nat_route_table.id
}

resource "oci_core_subnet" "pods_subnet" {
  cidr_block     = "10.1.128.0/18"
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  dns_label = "pod"
  display_name = "pod-subnet"
  prohibit_public_ip_on_vnic = true
  route_table_id = oci_core_route_table.nat_route_table.id
}

resource "oci_core_subnet" "bastion_subnet" {
  cidr_block     = local.bastion_cidr_block
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  dns_label = "bastion"
  display_name = "bastion-subnet"
  prohibit_public_ip_on_vnic = var.bastion_subnet_private
  route_table_id = oci_core_route_table.service_route_table.id
  security_list_ids = [oci_core_security_list.bastion_security_list.0.id]
  count = var.create_bastion ? 1 : 0
}

