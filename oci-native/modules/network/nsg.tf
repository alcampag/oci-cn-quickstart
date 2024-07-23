module "oke-network" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"
  compartment_id = var.network_compartment_id
  # IAM - Policies
  create_iam_autoscaler_policy = "never"
  create_iam_kms_policy = "never"
  create_iam_operator_policy = "never"
  create_iam_worker_policy = "never"
  # Network module - VCN
  subnets = {
    bastion = { create = "never"}
    operator = { create = "never" }
    pub_lb = { create = "never" }
    int_lb = { create = "never" }
    cp = { create = "never" }
    workers = { create = "never" }
    pods = { create = "never" }
  }
  nsgs = {
    bastion = {create = var.create_bastion_subnet ? "always" : "never"}
    operator = { create = "never"}
    pub_lb = {create = "never"}
    int_lb = {create = "never"}
    cp = {create = "always"}
    workers = {create = "always"}
    pods = {create = "always"}
  }
  network_compartment_id = var.network_compartment_id
  create_vcn = false
  vcn_id = oci_core_vcn.spoke_vcn.id
  # Network module - security
  allow_node_port_access = true
  allow_pod_internet_access = true
  allow_worker_internet_access = true
  allow_worker_ssh_access = true
  create_cluster = false
  # Bastion
  create_bastion = false

  # Operator
  create_operator = false

  providers = {
    oci.home = oci.home
  }
}

resource "oci_core_network_security_group_security_rule" "pods_nsg_rule_lb_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = module.oke-network.pod_nsg_id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "LBs to pods, - stateless ingress"
}

resource "oci_core_network_security_group_security_rule" "pods_nsg_rule_lb_egress" {
  direction                 = "EGRESS"
  network_security_group_id = module.oke-network.pod_nsg_id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.oke_lb_nsg.id
  stateless = true
  description = "Pods to LBs, - stateless egress"
}
