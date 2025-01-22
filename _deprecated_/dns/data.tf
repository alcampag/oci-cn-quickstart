resource "null_resource" "wait_for_dns_resolver_provision" {
  provisioner "local-exec" {
    command = "while [ \"$state\" != \"AVAILABLE\" ]; do state=$(oci network vcn-dns-resolver-association get --vcn-id $vcn_id --region $region --query 'data.\"lifecycle-state\"' --raw-output); sleep 5; done"
    environment = {
      vcn_id = var.vcn_id
      region = var.region
    }
  }
}

data "oci_core_vcn_dns_resolver_association" "vcn_resolver" {
  vcn_id = var.vcn_id
  depends_on = [null_resource.wait_for_dns_resolver_provision]
}