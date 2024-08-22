
data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
  cluster_id = var.oke_cluster_id
  endpoint = "PRIVATE_ENDPOINT"
}

data "oci_resourcemanager_private_endpoint_reachable_ip" "oke_cp_ip" {
  private_endpoint_id = oci_resourcemanager_private_endpoint.oke_private_endpoint.id
  private_ip          = local.kube_private_ip
}