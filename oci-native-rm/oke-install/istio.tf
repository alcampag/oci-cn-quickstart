resource "helm_release" "istio_base" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "base"
  name  = "istio-base"
  namespace = "istio-system"
  create_namespace = true
  wait = true
  count = var.install_istio ? 1 : 0
}

resource "helm_release" "istio_control_plane" {
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istiod"
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
  chart = "cni"
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
  chart = "ztunnel"
  name  = "ztunnel"
  namespace = "istio-system"
  wait = true
  depends_on = [helm_release.istio_cni]
  count = var.install_istio ? 1 : 0
}

# Add namespace to ambient mesh kubectl label namespace default istio.io/dataplane-mode=ambient