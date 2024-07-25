resource "oci_load_balancer_load_balancer" "oke_lb" {
  compartment_id = var.network_compartment_id
  display_name   = "oke-lb"
  shape          = "flexible"
  subnet_ids = [oci_core_subnet.service_subnet.id]
  is_private = var.lb_subnet_private
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  network_security_group_ids = [oci_core_network_security_group.oke_lb_nsg.id]
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

resource "oci_load_balancer_backend_set" "http_dummy_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.oke_lb.id
  name             = "HTTP_DUMMY"
  policy           = "LEAST_CONNECTIONS"
  health_checker {
    protocol = "HTTP"
    url_path = "/"
  }
  count = var.create_lb_http_redirect_rule ? 1 : 0
}

resource "oci_load_balancer_listener" "http_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.http_dummy_backend_set.0.name
  load_balancer_id         = oci_load_balancer_load_balancer.oke_lb.id
  name                     = "http_listener"
  port                     = 80
  protocol                 = "HTTP"
  rule_set_names = [oci_load_balancer_rule_set.oke_lb_redirect_rule.0.name]
  count = var.create_lb_http_redirect_rule ? 1 : 0
}