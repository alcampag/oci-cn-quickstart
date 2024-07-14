# First, create all the network resources to host OKE
# Also creates an initial LB that will be used as Ingress for the pods
module "oke-network" {
  # TODO: Option to enable LB logging (might require a log group)
  source = "./modules/network"
  network_compartment_id = var.network_compartment_id ? var.network_compartment_id : var.compartment_ocid
  create_bastion_subnet = var.create_bastion_subnet
}

# Create an OKE cluster on top of the network resources
# TODO

# Optionally, create OCI Logging Analytics, Vault, APM
# TODO

# Install tools on OKE and enable add-ons
# TODO