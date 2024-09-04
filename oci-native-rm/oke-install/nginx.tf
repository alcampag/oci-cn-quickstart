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
    name  = "controller.service.annotations"
    value = var.nginx_service_annotations
  }
}





