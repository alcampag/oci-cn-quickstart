resource "oci_dns_resolver" "default_vcn_resolver" {
  resolver_id = data.oci_core_vcn_dns_resolver_association.vcn_resolver.dns_resolver_id
  attached_views {
    view_id = oci_dns_view.np_private_view.id
  }
}

resource "oci_dns_view" "np_private_view" {
  compartment_id = var.compartment_id
  display_name = var.custom_private_view_name
  scope = "PRIVATE"
}

resource "oci_dns_zone" "np_zone" {
  for_each = toset(var.vcn_custom_private_zone_domain_names)
  compartment_id = var.compartment_id
  name           = each.key
  zone_type      = "PRIMARY"
  view_id = oci_dns_view.np_private_view.id
  scope = "PRIVATE"
}

locals {
  #lb_private_ip = one(toset([for ip in oci_load_balancer_load_balancer.oke_lb.ip_address_details : ip.ip_address if ip.is_public == false]))
}

/*resource "oci_dns_rrset" "lb_dns_record" {
  domain          = "ingress.${oci_dns_zone.oke_lb_endpoint_zone.name}"
  rtype           = "A"
  items {
    domain = "ingress.${oci_dns_zone.oke_lb_endpoint_zone.name}"
    rdata  = local.lb_private_ip
    rtype  = "A"
    ttl    = 3600
  }
  zone_name_or_id = oci_dns_zone.oke_lb_endpoint_zone.id
  view_id = oci_dns_view.oke_private_lb_view.id
  scope = "PRIVATE"
}*/

