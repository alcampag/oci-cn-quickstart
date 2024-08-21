data "oci_core_subnet" "oke_cp_subnet_data" {
  subnet_id = var.oke_cp_subnet_id
}

data "oci_core_subnet" "worker_subnet_data" {
  subnet_id = var.worker_subnet_id
}

data "oci_core_subnet" "service_subnet_data" {
  subnet_id = var.service_subnet_id
}

data "oci_core_subnet" "pod_subnet_data" {
  subnet_id = var.pod_subnet_id
}