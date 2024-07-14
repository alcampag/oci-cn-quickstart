resource "oci_core_subnet" "oke_lb_subnet" {
  cidr_block     = var.lb_subnet_cidr
  compartment_id = var.network_compartment_id
  vcn_id         = module.oke-network.vcn_id
  prohibit_public_ip_on_vnic = var.lb_subnet_private
}



resource "oci_load_balancer_load_balancer" "oke_lb" {
  compartment_id = var.network_compartment_id
  display_name   = "oke-lb"
  shape          = "flexible"
  subnet_ids = [oci_core_subnet.oke_lb_subnet.id]
  is_private = var.lb_subnet_private
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  network_security_group_ids = [oci_core_network_security_group.oke_lb_nsg.id]
}

resource "oci_load_balancer_rule_set" "oke_lb_redirect_rule" {
  load_balancer_id = oci_load_balancer_load_balancer.oke_lb.id
  name             = "https_redirect"
  items {
    action = "REDIRECT"
    description = "Redirect all HTTP traffic to HTTPS"
    conditions {
      attribute_name = "PATH"
      attribute_value = "http://"
      operator = "PREFIX_MATCH"
    }
    redirect_uri {
      protocol = "HTTPS"
      port = 443
    }
  }
  count = var.create_lb_https_redirect_rule ? 1 : 0
}