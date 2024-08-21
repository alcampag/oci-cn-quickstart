output "vcn_id" {
  value = oci_core_vcn.spoke_vcn.id
}

# SUBNETS

output "cp_subnet_id" {
  value = oci_core_subnet.oke_cp_subnet.id
}

output "pod_subnet_id" {
  value = oci_core_subnet.pods_subnet.id
}

output "worker_subnet_id" {
  value = oci_core_subnet.worker_subnet.id
}

output "service_subnet_id" {
  value = oci_core_subnet.service_subnet.id
}

output "bastion_subnet_id" {
  value = var.create_bastion ? oci_core_subnet.bastion_subnet[0].id : null
}

# NSG

output "cp_nsg_id" {
  value = oci_core_network_security_group.cp_nsg.id
}

output "pod_nsg_id" {
  value = oci_core_network_security_group.pod_nsg.id
}

output "worker_nsg_id" {
  value = oci_core_network_security_group.worker_nsg.id
}

output "lb_nsg_id" {
  value = oci_core_network_security_group.oke_lb_nsg.id
}

output "apigw_nsg_id" {
  value = oci_core_network_security_group.apigw_nsg.id
}
