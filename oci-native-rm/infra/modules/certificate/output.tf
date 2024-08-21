output "apigw_certificate_id" {
  value = oci_certificates_management_certificate.apigw_certificate.id
}

output "np_ca_id" {
  value = oci_certificates_management_certificate_authority.np_ca.id
}

