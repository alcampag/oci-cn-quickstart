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
    bastion = { create = var.create_bastion_subnet ? "always" : "never"
      cidr = "10.0.0.8/29" }
    operator = { create = "never" }
    pub_lb = { create = "never" }
    int_lb = { create = "never" }
    cp = { cidr = "10.0.0.0/29" }
    workers = { cidr = "10.0.8.0/21" }
    pods = { create = var.cni_type == "npn" ? "always" : "never"
      cidr = "10.0.128.0/18" }
  }
  nsgs = {
    bastion = {create = var.create_bastion_subnet ? "always" : "never"}
    operator = { create = "never"}
    pub_lb = {create = "never"}
    int_lb = {create = "never"}
    cp = {create = "always"}
    workers = {create = "always"}
    pods = {create = var.cni_type == "npn" ? "always" : "never"}
  }
  network_compartment_id = var.network_compartment_id
  assign_dns = true
  create_vcn = true
  vcn_cidrs = ["10.0.0.0/16"]
  vcn_dns_label = "oke"
  vcn_name = "oke-quickstart-vcn"
  lockdown_default_seclist = true
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