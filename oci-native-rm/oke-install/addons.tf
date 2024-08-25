resource "oci_containerengine_addon" "oke_cert_manager" {
  addon_name                       = "CertManager"
  cluster_id                       = var.oke_cluster_id
  remove_addon_resources_on_delete = true
}

resource "oci_containerengine_addon" "oke_metrics_server" {
  addon_name                       = "KubernetesMetricsServer"
  cluster_id                       = var.oke_cluster_id
  remove_addon_resources_on_delete = true
  depends_on = [oci_containerengine_addon.oke_cert_manager]
}

resource "oci_containerengine_addon" "oci_native_ingress" {
  addon_name                       = "NativeIngressController"
  cluster_id                       = var.oke_cluster_id
  configurations {
    key = "compartmentId"
    value = var.network_compartment_id
  }
  configurations {
    key = "loadBalancerSubnetId"
    value = var.lb_subnet_id
  }
  configurations {
    key = "authType"
    value = "workloadIdentity"
  }
  configurations {
    key = "numOfReplicas"
    value = "1"
  }
  remove_addon_resources_on_delete = true
  depends_on = [oci_containerengine_addon.oke_cert_manager]
}