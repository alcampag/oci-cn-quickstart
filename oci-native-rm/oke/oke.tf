locals {
  is_cp_subnet_private = data.oci_core_subnet.cp_subnet_data.prohibit_public_ip_on_vnic
  is_lb_subnet_private = data.oci_core_subnet.lb_subnet_data.prohibit_public_ip_on_vnic
  is_flannel = var.cni_type == "flannel"

  ssh_public_key = ""     # Insert the ssh public key to access worker nodes

  runcmd_bootstrap_ubuntu = "oke bootstrap"
  runcmd_bootstrap_oracle_linux = "sudo /usr/libexec/oci-growfs -y"

  cloud_init = {
    runcmd = compact([
      local.runcmd_bootstrap_ubuntu,        # Modify here depending on the OS selected for the worker nodes
    ])
  }
}

module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.2.3"
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
    pub_lb = { id = local.is_lb_subnet_private ? null : var.lb_subnet_id }
    int_lb = { id = local.is_lb_subnet_private ? var.lb_subnet_id : null }
    cp = { id = var.cp_subnet_id }
    workers = { id = var.worker_subnet_id }
    pods = { id = local.is_flannel ? null : var.pod_subnet_id }
  }
  nsgs = {
    bastion = { create = "never" }
    operator = { create = "never" }
    pub_lb = {create = "never" }
    int_lb = { create = "never"}
    cp = { id = var.cp_nsg_id }
    workers = { id = var.worker_nsg_id }
    pods = { create = "never", id = var.cni_type == "flannel" ? null : var.pod_nsg_id }
  }
  network_compartment_id = var.network_compartment_id
  assign_public_ip_to_control_plane = ! local.is_cp_subnet_private
  create_vcn = false
  vcn_id = var.vcn_id
  # Network module - security
  control_plane_allowed_cidrs = var.cp_allowed_cidr_list # ["0.0.0.0/0"]
  control_plane_is_public = ! local.is_cp_subnet_private
  load_balancers = local.is_lb_subnet_private ? "internal" : "public"
  preferred_load_balancer = local.is_lb_subnet_private ? "internal" : "public"
  # Cluster module
  create_cluster = true
  cluster_kms_key_id = null
  cluster_name = var.cluster_name
  cluster_type = var.cluster_type
  cni_type = var.cni_type
  kubernetes_version = var.kubernetes_version
  services_cidr      = var.services_cidr
  pods_cidr = var.pods_cidr
  use_signed_images  = false
  use_defined_tags = false

  # Bastion
  create_bastion = false

  # Operator
  create_operator = false

  # OKE data plane, node workers
  worker_pool_mode = "node-pool"
  worker_is_public = false
  worker_disable_default_cloud_init = true                                                                    # Set it to true if you are planning to use Ubuntu nodes
  #ssh_public_key = local.ssh_public_key                                                                      # De-comment if you want a ssh key to access the worker nodes, be sure to set the local variable
  worker_image_type = "custom"                                                                                # Better to use custom shapes for both Ubuntu and Oracle Linux nodes
  worker_image_id = ""                                                                                        # The image id to use for the worker nodes. For Oracle Linux images, check this link: https://docs.oracle.com/en-us/iaas/images/oke-worker-node-oracle-linux-8x/index.htm
                                                                                                              # For Ubuntu images, you need to import it in your tenancy, see: https://canonical-oracle.readthedocs-hosted.com/en/latest/oracle-how-to/deploy-oke-nodes-using-ubuntu-images/
  worker_cloud_init = [{ content_type = "text/cloud-config", content = yamlencode(local.cloud_init)}]         # Cloud init is different, depending if you are using Ubuntu or Oracle Linux nodes, see local.cloud_init variable


  worker_pools = {
    np1 = {
      shape = "VM.Standard.E4.Flex",        # No need to specify ocpus and memory if you are not using a Flex shape
      size = 1,
      placement_ads = ["1"],                # As best practice, one node pool should be associated only to one specific AD
      ocpus = 2,
      #image_id = "",                        # You can override global worker node parameters individually in the node pool
      memory = 16,
      boot_volume_size = 150,
      ignore_initial_pool_size = true,       # If set to true, node pool size drift won't be accounted in Terraform, useful also if this pool is autoscaled by an external component or user
      create = false                          # Set it to true so that the node pool is created, REMEMBER to set also the relative NSG id!!!
    }
  }

  providers = {
    oci.home = oci.home
  }
}


# Add on section, you can also manage addons through Terraform

/*resource "oci_containerengine_addon" "oke_cert_manager" {
  addon_name                       = "CertManager"
  cluster_id                       = module.oke.cluster_id
  remove_addon_resources_on_delete = false
  depends_on = [module.oke]
}

resource "oci_containerengine_addon" "oke_metrics_server" {
  addon_name                       = "KubernetesMetricsServer"
  cluster_id                       = module.oke.cluster_id
  remove_addon_resources_on_delete = false
  depends_on = [module.oke, oci_containerengine_addon.oke_cert_manager]
}*/