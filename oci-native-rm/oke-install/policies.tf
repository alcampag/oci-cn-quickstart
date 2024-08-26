locals {
  statements = tolist([
    "Allow any-user to manage load-balancers in compartment id ${var.network_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to use virtual-network-family in compartment id ${var.network_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage cabundles in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage cabundle-associations in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage leaf-certificates in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to read leaf-certificate-bundles in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage certificate-associations in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to read certificate-authorities in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage certificate-authority-associations in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to read certificate-authority-bundles in compartment id ${var.certificate_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to read public-ips in compartment id ${var.network_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage floating-ips in compartment id ${var.network_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to manage waf-family in compartment id ${var.waf_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}",
    "Allow any-user to read cluster-family in compartment id ${var.oke_cluster_compartment_id} where all {request.principal.type = 'workload', request.principal.namespace = 'native-ingress-controller-system', request.principal.service_account = 'oci-native-ingress-controller', request.principal.cluster_id = '${var.oke_cluster_id}'}"
  ])
  #external_dns_statements = tolist([
  #  "Allow any-user to manage dns in compartment id ${var.comprtment_id} where all {request.principal.type='workload',request.principal.cluster_id='${var.oke_cluster_id}',request.principal.service_account='external-dns', request.principal.namespace = 'external-dns'}"
  #])
  #statements = concat(local.oci_native_ingress_statements, local.external_dns_statements)
}

resource "oci_identity_policy" "oke_native_ingress_policies" {
  compartment_id = var.policy_compartment_id
  description    = "Policies for using the OCI Native Ingress with workload identity"
  name           = "oci-native-ingress-policies"
  statements = local.statements
  count = var.install_native_ingress ? 1 : 0
}