resource "oci_load_balancer_load_balancer" "oke_lb" {
  compartment_id = var.network_compartment_id
  display_name   = var.lb_name
  shape          = "flexible"
  subnet_ids = [var.subnet_id]
  is_private = var.is_private
  shape_details {
    maximum_bandwidth_in_mbps = var.lb_max_bandwidth
    minimum_bandwidth_in_mbps = var.lb_min_bandwidth
  }
  network_security_group_ids = [var.lb_nsg_id]
}

resource "oci_load_balancer_rule_set" "oke_lb_redirect_rule" {
  load_balancer_id = oci_load_balancer_load_balancer.oke_lb.id
  name             = "http_redirect"
  items {
    action = "REDIRECT"
    description = "Redirect all HTTP traffic to HTTPS"
    conditions {
      attribute_name = "PATH"
      attribute_value = "/"
      operator = "PREFIX_MATCH"
    }
    redirect_uri {
      protocol = "HTTPS"
      port = 443
    }
  }
  count = var.create_lb_http_redirect_rule ? 1 : 0
  lifecycle {
    create_before_destroy = true
    ignore_changes = all
  }
}