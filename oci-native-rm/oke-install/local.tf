//noinspection HILUnresolvedReference
locals {
  is_cp_subnet_private = data.oci_core_subnet.cp_subnet.prohibit_public_ip_on_vnic
  kube_host = yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content).clusters.0.cluster.server
  kube_private_ip = regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}", local.kube_host)
  kube_cluster_ca_certificate = base64decode(yamldecode(data.oci_containerengine_cluster_kube_config.cluster_kube_config.content).clusters.0.cluster.certificate-authority-data)
  cluster_endpoint = local.is_cp_subnet_private ? "https://${data.oci_resourcemanager_private_endpoint_reachable_ip.oke_cp_ip.ip_address}:6443" : null
}