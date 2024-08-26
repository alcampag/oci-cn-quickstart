data "oci_core_subnet" "cp_subnet" {
  subnet_id = var.cp_subnet_id
}


data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
  cluster_id = var.oke_cluster_id
  endpoint = local.is_cp_subnet_private ? "PRIVATE_ENDPOINT" : "PUBLIC_ENDPOINT"
}

data "oci_resourcemanager_private_endpoint_reachable_ip" "oke_cp_ip" {
  private_endpoint_id = oci_resourcemanager_private_endpoint.oke_private_endpoint.0.id
  private_ip          = local.kube_private_ip
  count = local.is_cp_subnet_private ? 1 : 0
}

data "oci_identity_region_subscriptions" "home" {
  tenancy_id = var.tenancy_ocid
  filter {
    name   = "is_home_region"
    values = [true]
  }
}