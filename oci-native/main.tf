# First, create all the network resources to host OKE
# Also creates an initial LB that will be used as Ingress for the pods
module "network" {
  # TODO: Option to enable LB logging (might require a log group)
  source = "./modules/network"
  network_compartment_id = var.network_compartment_id != null ? var.network_compartment_id : var.compartment_ocid
  create_bastion = true
  region = var.region
}

# Data module
module "current-network" {
  source = "./modules/data/subnets"
  region = var.region
  oke_cp_subnet_id = module.network.cp_subnet_id
  worker_subnet_id = module.network.worker_subnet_id
  pod_subnet_id = module.network.pod_subnet_id
  service_subnet_id = module.network.service_subnet_id
  lb_nsg_id = module.network.lb_nsg_id
  cp_nsg_id = module.network.cp_nsg_id
  worker_nsg_id = module.network.worker_nsg_id
  pod_nsg_id = module.network.pod_nsg_id
}

# Create an OKE cluster on top of the network resources
module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"
  compartment_id = var.compartment_ocid
  network_compartment_id = var.compartment_ocid
  create_iam_autoscaler_policy = "never"
  create_iam_kms_policy = "never"
  create_iam_operator_policy = "never"
  create_iam_worker_policy = "never"
  create_vcn = false

  vcn_id = module.network.vcn_id
  subnets = {
    int_lb = {
      create = "never"
      id = module.current-network.service_subnet_id
    }
    cp = {
      create = "never"
      id = module.current-network.oke_cp_subnet_id
    }
    workers = {
      create = "never"
      id = module.current-network.worker_subnet_id
    }
    pods = {
      create = "never"
      id = module.current-network.pod_subnet_id
    }
  }
  nsgs = {
    int_lb = {
      create = "never"
      id = module.current-network.lb_nsg_id
    }
    cp = {
      create = "never"
      id = module.current-network.cp_nsg_id
    }
    workers = {
      create = "never"
      id = module.current-network.worker_nsg_id
    }
    pods = {
      create = "never"
      id = module.current-network.pod_nsg_id
    }
  }
  assign_public_ip_to_control_plane = false
  control_plane_is_public = false
  load_balancers = "internal"
  preferred_load_balancer = "internal"
  worker_is_public = false
  create_cluster = true
  cluster_name = "oke-quickstart-oci-native"
  cluster_type = "enhanced"
  cni_type = "npn"
  kubernetes_version = var.kubernetes_version
  services_cidr      = "10.96.0.0/16"
  worker_pool_mode = "node-pool"
  worker_pool_size = 0
  worker_image_type = "custom"
  worker_image_id = local.oke_x86_image_id
  worker_cloud_init = [
    {
      content      = <<-EOT
    runcmd:
      - sudo /usr/libexec/oci-growfs -y
    EOT
      content_type = "text/cloud-config",
    }]
  freeform_tags = {
    workers = {
      "cluster" = "oke-quickstart"
    }
  }
  worker_pools = {
    np1 = {
      shape                = "VM.Standard.E4.Flex",
      ocpus                = 2,
      memory               = 16,
      boot_volume_size     = 50,
      node_cycling_enabled = true,
      create               = true
    }
  }
  create_bastion = false
  create_operator = false

  providers = {
    oci.home = oci.home
  }
}

module "oke-tools" {
  source = "./modules/oke-tools"
  region = var.region
  oke_cluster_id = module.oke.cluster_id
  network_compartment_id = var.compartment_ocid
  service_subnet_id = module.network.service_subnet_id
}

module "policy" {
  source = "./modules/policy"
  region = var.region
  comprtment_id = var.compartment_ocid
  oke_cluster_id = module.oke.cluster_id
}

# Optionally, create OCI Logging Analytics, Vault, APM
# TODO

# Install tools on OKE and enable add-ons
# TODO