output "cluster_ca_key_id" {
  value = oci_kms_key.cluster_ca_key.id
}

output "np_ca_key_id" {
  value = oci_kms_key.np_environment_ca_key.id
}

output "root_ca_key_id" {
  value = oci_kms_key.root_ca_key.id
}