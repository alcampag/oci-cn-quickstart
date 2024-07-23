resource "oci_containerengine_addon" "oke_cert_manager" {
  addon_name                       = "CertManager"
  cluster_id                       = var.oke_cluster_id
  remove_addon_resources_on_delete = false
}

resource "oci_containerengine_addon" "oke_metrics_server" {
  addon_name                       = "KubernetesMetricsServer"
  cluster_id                       = var.oke_cluster_id
  remove_addon_resources_on_delete = false
  depends_on = [oci_containerengine_addon.oke_cert_manager]
}