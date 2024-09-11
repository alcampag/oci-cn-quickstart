locals {
  nginx_service_annotations = compact([for line in split("\n",var.nginx_service_annotations) : chomp(line)])
  #nginx_service_annotations_set = toset({for items in local.nginx_service_annotations : split(":", items)[0] => split(":", items)[1]})
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
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
  dynamic "set" {
    for_each = local.nginx_service_annotations
    content {
      name = "controller.service.annotations.${replace(trimspace(split(":", set.value)[0]), "." , "\\.")}"
      value = trim(trimspace(split(":", set.value)[1]), "\"")
    }
  }
}





