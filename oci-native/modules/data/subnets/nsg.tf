data "oci_core_network_security_group" "lb_nsg_data" {
  network_security_group_id = var.lb_nsg_id
}

data "oci_core_network_security_group" "cp_nsg_data" {
  network_security_group_id = var.cp_nsg_id
}

data "oci_core_network_security_group" "worker_nsg_data" {
  network_security_group_id = var.worker_nsg_id
}

data "oci_core_network_security_group" "pod_nsg_data" {
  network_security_group_id = var.pod_nsg_id
}