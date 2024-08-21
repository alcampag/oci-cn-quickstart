resource "oci_certificates_management_certificate" "oke_wildcard_lb_certificate" {
  compartment_id = var.compartment_id
  name           = "oke-lb-certificate"
  description = "This is the certificate for enabling TLS encryption of OKE services exposed through the OKE LB. This should be a wildcard certificate and must be linked to the OKE LB"
  certificate_config {
    config_type = "ISSUED_BY_INTERNAL_CA"
    issuer_certificate_authority_id = oci_certificates_management_certificate_authority.cluster_ca.id
    certificate_profile_type = "TLS_SERVER"
    subject {
      common_name = var.lb_certificate_subject_common_name
    }
  }
}

resource "oci_certificates_management_certificate" "apigw_certificate" {
  compartment_id = var.compartment_id
  name           = "apigw-certificate"
  description = "This is the certificate for the APIGW. The subject common name will be the internal dns name of the APIGW."
  certificate_config {
    config_type = "ISSUED_BY_INTERNAL_CA"
    issuer_certificate_authority_id = oci_certificates_management_certificate_authority.np_ca.id
    certificate_profile_type = "TLS_SERVER_OR_CLIENT"
    subject {
      common_name = var.apigw_certificate_subject_common_name
    }
  }
}