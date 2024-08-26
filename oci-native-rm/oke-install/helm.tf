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
}

resource "helm_release" "istio_base" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/base"
  name  = "istio-base"
  namespace = "istio-system"
  create_namespace = true
  wait = true
}

resource "helm_release" "istio_control_plane" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/istiod"
  name  = "istiod"
  namespace = "istio-system"
  set {
    name  = "profile"
    value = "ambient"
  }
  wait = true
  depends_on = [helm_release.istio_base]
}

resource "helm_release" "istio_cni" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/cni"
  name  = "istio-cni"
  set {
    name  = "profile"
    value = "ambient"
  }
  namespace = "istio-system"
  wait = true
  depends_on = [helm_release.istio_control_plane]
}

resource "helm_release" "ztunnel" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/ztunnel"
  name  = "ztunnel"
  namespace = "istio-system"
  wait = true
  depends_on = [helm_release.istio_cni]
}

