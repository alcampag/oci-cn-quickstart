locals {
  nginx_service_annotations = split("/n",var.nginx_service_annotations)
}

resource "helm_release" "nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  name  = var.nginx_release_name  # <release-name>-ingress-nginx-controller
  version = var.nginx_chart_version
  create_namespace = true
  namespace = var.nginx_namespace
  set {
    name  = "controller.service.type"
    value = var.nginx_service_type
  }
  dynamic "set" {
    for_each = local.nginx_service_annotations
    content {
      name = "controller.service.annotations.${replace(set.key, "." , "\\.")}"
      value = set.value
    }
  }
}





