data "oci_identity_region_subscriptions" "home" {
  tenancy_id = var.tenancy_ocid
  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "oci_containerengine_node_pool_option" "oke_images" {
  node_pool_option_id = "all"
  compartment_id = var.compartment_ocid
}