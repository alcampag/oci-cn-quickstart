locals {
  lb_private_ip = one(toset([for ip in oci_load_balancer_load_balancer.oke_lb.ip_address_details : ip.ip_address if ip.is_public == false]))
}