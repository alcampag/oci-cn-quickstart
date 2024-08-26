resource "helm_release" "istio_base" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/base"
  name  = "istio-base"
  namespace = "istio-system"
  create_namespace = true
  wait = true
  count = var.install_istio ? 1 : 0
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
  count = var.install_istio ? 1 : 0
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
  count = var.install_istio ? 1 : 0
}

resource "helm_release" "ztunnel" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istio/ztunnel"
  name  = "ztunnel"
  namespace = "istio-system"
  wait = true
  depends_on = [helm_release.istio_cni]
  count = var.install_istio ? 1 : 0
}