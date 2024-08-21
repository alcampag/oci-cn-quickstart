//noinspection HILUnresolvedReference
locals {
  #kubeconfig_content = data.oci_containerengine_cluster_kube_config.kube_config.content
  #kube_host = yamldecode(local.kubeconfig_content).clusters.0.cluster.server
  #kube_cluster_ca_certificate = base64decode(yamldecode(local.kubeconfig_content).clusters.0.cluster.certificate-authority-data)
  oke_x86_image_id = one(toset([for image in data.oci_containerengine_node_pool_option.oke_images.sources : image.image_id if image.source_name == var.oke_image_name]))
  home_region = one(data.oci_identity_region_subscriptions.home.region_subscriptions[*].region_name)
}