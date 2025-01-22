resource "oci_kms_vault" "oci_vault" {
  compartment_id = var.compartment_id
  display_name   = var.vault_name
  vault_type     = "DEFAULT"
}

resource "oci_kms_key" "root_ca_key" {
  compartment_id      = var.compartment_id
  display_name        = "root-ca-key"
  management_endpoint = oci_kms_vault.oci_vault.management_endpoint
  protection_mode = "HSM"   # CAs can be created only with HSM protected keys
  key_shape {
    algorithm = "RSA"
    length    = 256
  }
}

resource "oci_kms_key" "np_environment_ca_key" {
  compartment_id      = var.compartment_id
  display_name        = "np-ca-key"
  management_endpoint = oci_kms_vault.oci_vault.management_endpoint
  protection_mode = "HSM"   # CAs can be created only with HSM protected keys
  key_shape {
    algorithm = "RSA"
    length    = 256
  }
}

resource "oci_kms_key" "cluster_ca_key" {
  compartment_id      = var.compartment_id
  display_name        = "np-cluster-ca-key"
  management_endpoint = oci_kms_vault.oci_vault.management_endpoint
  protection_mode = "HSM"   # CAs can be created only with HSM protected keys
  key_shape {
    algorithm = "RSA"
    length    = 256
  }
}
