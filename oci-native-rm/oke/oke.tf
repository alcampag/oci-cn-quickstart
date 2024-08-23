module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"
  compartment_id = var.oke_compartment_id
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
    int_lb = { id = var.lb_subnet_id }
    cp = { id = var.cp_subnet_id }
    workers = { id = var.worker_subnet_id }
    pods = { id = var.pod_subnet_id }
  }
  nsgs = {
    bastion = { create = "never" }
    operator = { create = "never" }
    pub_lb = {create = "never" }
    int_lb = { create = "never"}
    cp = { id = var.cp_nsg_id }
    workers = { create = "never" }
    pods = { create = "never" }
  }
  network_compartment_id = var.network_compartment_id
  assign_public_ip_to_control_plane = false
  create_vcn = false
  vcn_id = var.vcn_id
  # Network module - security
  control_plane_allowed_cidrs = var.cp_allowed_cidr_list # ["0.0.0.0/0"]
  control_plane_is_public = false
  load_balancers = "internal"
  preferred_load_balancer = "internal"
  worker_is_public = false
  # Cluster module
  create_cluster = true
  cluster_kms_key_id = null
  cluster_name = var.cluster_name
  cluster_type = "enhanced"
  cni_type = "npn"
  kubernetes_version = var.kubernetes_version
  services_cidr      = "10.96.0.0/16"
  use_signed_images  = false
  use_defined_tags = false

  # Bastion
  create_bastion = false

  # Operator
  create_operator = false

  providers = {
    oci.home = oci.home
  }
}