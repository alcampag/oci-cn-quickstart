locals {
  lb_private_ip = one(toset([for ip in oci_load_balancer_load_balancer.oke_lb.ip_address_details : ip.ip_address if ip.is_public == false]))
  bastion_cidr_block = "10.1.0.8/29"
  test_hostname_ingress = "ingress.lb.oke.oraclecloud.com"
}