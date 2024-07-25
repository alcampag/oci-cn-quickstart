terraform {
  required_version = ">=1.6.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=6.3.0"
      configuration_aliases = [oci.home]
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "oci" {
  region = var.region
}

provider "oci" {
  alias = "home"
  region = var.home_region
}