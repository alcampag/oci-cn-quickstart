terraform {
  required_version = ">=1.5.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

provider "oci" {
  region = var.region
}