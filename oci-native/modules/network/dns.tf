resource "oci_dns_resolver" "default_vcn_resolver" {
  resolver_id = data.oci_core_vcn_dns_resolver_association.vcn_resolver.dns_resolver_id
  attached_views {
    view_id = oci_dns_view.oke_private_lb_view.id
  }
  depends_on = [oci_core_vcn.spoke_vcn]
}

resource "oci_dns_view" "oke_private_lb_view" {
  compartment_id = var.network_compartment_id
  display_name = "oke-lb-view"
  scope = "PRIVATE"
}

resource "oci_dns_zone" "oke_lb_endpoint_zone" {
  compartment_id = var.network_compartment_id
  name           = "lb.oke.oraclecloud.com"
  zone_type      = "PRIMARY"
  view_id = oci_dns_view.oke_private_lb_view.id
  scope = "PRIVATE"
  depends_on = [oci_core_vcn.spoke_vcn]
}

resource "oci_dns_rrset" "lb_dns_record" {
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
}

