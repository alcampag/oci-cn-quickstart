locals {
  oci_native_ingress_statements = var.install_native_ingress ? tolist([
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
  ]) : []

  oke_vcn_native_cni_statements = tolist([
    "Allow any-user to manage instances in compartment <compartment-ocid-of-nodepool> where all { request.principal.id = '<cluster-ocid>' }",
    "Allow any-user to use private-ips in compartment <compartment-ocid-of-network-resources> where all { request.principal.id = '<cluster-ocid>' }",
    "Allow any-user to use network-security-groups in compartment <compartment-ocid-of-network-resources> where all { request.principal.id = '<cluster-ocid>' }"
  ])

  encrypt_boot_volume_vault_key_statements = tolist([
    "Allow service oke to use key-delegates in compartment <compartment-key> where target.key.id = '<key_OCID>'",
    "Allow service blockstorage to use keys in compartment <compartment-key> where target.key.id = '<key_OCID>'",
    "Allow any-user to use key-delegates in compartment <compartment-key> where ALL {request.principal.type='nodepool', target.key.id = '<key_OCID>'}"
  ])

  encrypt_block_volume_vault_key_statements = tolist([
    "Allow service blockstorage to use keys in compartment <compartment-key> where target.key.id = '<key-ocid>'",
    "Allow any-user to use key-delegates in compartment <compartment-key> where ALL {request.principal.type = 'cluster', target.key.id = '<key-ocid>'}"
  ])

  # ALL { resource.type='filesystem', resource.compartment.id = '<file_system_compartment_OCID>' }
  encrypt_file_system_vault_key_statements = tolist([
    "Allow dynamic-group <dynamic-group-name> to use keys in compartment <key-compartment-name>",
    "Allow any-user to use key-delegates in compartment <compartment-key> where ALL {request.principal.type = 'cluster', target.key.id = '<key_OCID>'}"
  ])

  # https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengconfiguringloadbalancersnetworkloadbalancers-subtopic.htm#contengcreatingloadbalancer_topic-Specifying_Load_Balancer_Security_Rule_Management_Annotation
  oke_nsg_management_statements = tolist([
    "ALLOW any-user to manage network-security-groups in compartment <compartment-name> where request.principal.type = 'cluster'",
    "ALLOW any-user to manage vcns in compartment <compartment-name> where request.principal.type = 'cluster'",
    "ALLOW any-user to manage virtual-network-family in compartment <compartment-name> where request.principal.type = 'cluster'"
  ])

  oke_tagging_different_compartments = tolist([
    "Allow any-user to use tag-namespace in compartment <compartment-ocid-tag-namespace> where all { request.principal.id = '<cluster-ocid>' }"
  ])

  oke_capacity_reservation_statements = tolist([
    "Allow service oke to use compute-capacity-reservations in compartment id <compartment_capacity>",
    "Allow any-user to use compute-capacity-reservations in tenancy where request.principal.type = 'nodepool'"
  ])

  oke_lb_use_reserved_public_ips = tolist([
    "ALLOW any-user to read public-ips in tenancy where request.principal.type = 'cluster'",
    "ALLOW any-user to manage floating-ips in tenancy where request.principal.type = 'cluster'"
  ])

  oke_nlb_use_reserved_public_ips = tolist([
    "ALLOW any-user to use private-ips in TENANCY where ALL {request.principal.type = 'cluster', request.principal.compartment.id=target.compartment.id}",
    "ALLOW any-user to manage public-ips in TENANCY where ALL {request.principal.type = 'cluster', request.principal.compartment.id=target.compartment.id}"
  ])

  oke_use_nsg_annotation = tolist([
    "Allow any-user to use network-security-groups in compartment <compartment-ocid> where all { request.principal.id = '<cluster-ocid>' }"
  ])

  # https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengencryptingdata.htm

  #external_dns_statements = tolist([
  #  "Allow any-user to manage dns in compartment id ${var.comprtment_id} where all {request.principal.type='workload',request.principal.cluster_id='${var.oke_cluster_id}',request.principal.service_account='external-dns', request.principal.namespace = 'external-dns'}"
  #])
  statements = concat(local.oci_native_ingress_statements)
}

resource "oci_identity_policy" "oke_native_ingress_policies" {
  compartment_id = var.policy_compartment_id
  description    = var.policy_description
  name           = var.policy_name
  statements = local.statements
  count = var.create_policy ? 1 : 0
  provider = oci.home
}