resource "oci_waa_web_app_acceleration_policy" "oke_lb_waa_policy" {
  compartment_id = var.network_compartment_id
  display_name = "oke_lb_waa_policy"
  response_caching_policy {
    is_response_header_based_caching_enabled = true
  }
  response_compression_policy {
    gzip_compression {
      is_enabled = true
    }
  }
  count = var.create_lb_waa ? 1 : 0
}

resource "oci_waa_web_app_acceleration" "oke_lb_waa" {
  backend_type                   = "LOAD_BALANCER"
  compartment_id                 = oci_waa_web_app_acceleration_policy.oke_lb_waa_policy.0.compartment_id
  load_balancer_id               = oci_load_balancer_load_balancer.oke_lb.id
  web_app_acceleration_policy_id = oci_waa_web_app_acceleration_policy.oke_lb_waa_policy.0.id
  count = var.create_lb_waa ? 1 : 0
}