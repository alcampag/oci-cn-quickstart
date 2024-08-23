resource "helm_release" "nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  name  = "nginx-test"
  create_namespace = true
  namespace = "nginx"
  set {
    name  = "controller.service.type"
    value = "ClusterIP"
  }
}