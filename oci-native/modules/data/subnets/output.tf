output "service_subnet_id" {
  value = data.oci_core_subnet.service_subnet_data.id
}

output "oke_cp_subnet_id" {
  value = data.oci_core_subnet.oke_cp_subnet_data.id
}

output "pod_subnet_id" {
  value = data.oci_core_subnet.pod_subnet_data.id
}

output "worker_subnet_id" {
  value = data.oci_core_subnet.worker_subnet_data.id
}

output "lb_nsg_id" {
  value = data.oci_core_network_security_group.lb_nsg_data.id
}

output "cp_nsg_id" {
  value = data.oci_core_network_security_group.cp_nsg_data.id
}

output "pod_nsg_id" {
  value = data.oci_core_network_security_group.pod_nsg_data.id
}

output "worker_nsg_id" {
  value = data.oci_core_network_security_group.worker_nsg_data.id
}