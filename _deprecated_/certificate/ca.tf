resource "oci_certificates_management_certificate_authority" "root_ca" {
  compartment_id = var.compartment_id
  kms_key_id     = var.root_ca_key_id
  name           = "root-ca"
  description = "This is the root certificate authority that will validate all OCI Certificates in the tenancy. Note that it is not an authoritative CA, so if you are planning to expose a public service, you must import a certificate signed by a trusted CA."
  certificate_authority_config {
    config_type = "ROOT_CA_GENERATED_INTERNALLY"
    subject {
      common_name = var.root_ca_subject_common_name
    }
  }
}

resource "oci_certificates_management_certificate_authority" "np_ca" {
  compartment_id = var.compartment_id
  kms_key_id     = var.np_ca_key_id
  name           = "np-ca"
  description = "This is the subordinate CA for all the non-production workload environment"
  certificate_authority_config {
    config_type = "SUBORDINATE_CA_ISSUED_BY_INTERNAL_CA"
    issuer_certificate_authority_id = oci_certificates_management_certificate_authority.root_ca.id
    subject {
      common_name = var.np_ca_subject_common_name
    }
  }
}

# Optionally, you can create another subordinate CA for a single development environment

resource "oci_certificates_management_certificate_authority" "cluster_ca" {
  compartment_id = var.compartment_id
  kms_key_id     = var.cluster_ca_key_id
  name           = "oke-cluster-ca"
  description = "This subordinate CA will issue all certificates for the OKE cluster"
  certificate_authority_config {
    config_type = "SUBORDINATE_CA_ISSUED_BY_INTERNAL_CA"
    issuer_certificate_authority_id = oci_certificates_management_certificate_authority.np_ca.id
    subject {
      common_name = var.cluster_ca_subject_common_name
    }
  }
}