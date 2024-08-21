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

