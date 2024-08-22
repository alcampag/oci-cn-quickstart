terraform {
  required_version = ">=1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.7.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

provider "oci" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.kube_cluster_ca_certificate
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", var.oke_cluster_id, "--region", var.region]
      command     = "oci"
    }
  }
}