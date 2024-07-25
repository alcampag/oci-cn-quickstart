resource "oci_core_network_security_group" "worker_nsg" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  display_name = "worker-nsg"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_1" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.cp_nsg.id
  stateless = false
  description = "Allow ALL ingress to workers from Kubernetes control plane for webhooks served by workers"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_2" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.pod_nsg.id
  stateless = false
  description = "Allow ALL ingress to workers from pods"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_3" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow ALL ingress to workers from other workers"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_4" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.oke_lb_nsg.id
  stateless = false
  description = "Allow TCP ingress to workers for health check from public load balancers"
  tcp_options {
    destination_port_range {
      max = 10256
      min = 10256
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_5" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.oke_lb_nsg.id
  stateless = false
  description = "Allow TCP ingress to workers from internal load balancers"
  tcp_options {
    destination_port_range {
      max = 32767
      min = 30000
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_ingress_6" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "1"
  source_type = "CIDR_BLOCK"
  source = "0.0.0.0/0"
  stateless = false
  description = "Allow ICMP ingress to workers for path discovery"
  icmp_options {
    type = 3
    code = 4
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_1" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  destination_type = "CIDR_BLOCK"
  destination = "0.0.0.0/0"
  stateless = false
  description = "Allow ALL egress from workers to internet"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_2" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow ALL egress from workers to other workers"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_3" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "all"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.pod_nsg.id
  stateless = false
  description = "Allow ALL egress from workers to pods"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_4" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.cp_nsg.id
  stateless = false
  description = "Allow TCP egress from workers to Kubernetes API server"
  tcp_options {
    destination_port_range {
      max = 6443
      min = 6443
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_5" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  destination_type = "SERVICE_CIDR_BLOCK"
  destination = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")
  stateless = false
  description = "Allow TCP egress from workers to OCI Services"
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_6" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.cp_nsg.id
  stateless = false
  description = "Allow TCP egress to OKE control plane from workers for health check"
  tcp_options {
    destination_port_range {
      max = 10250
      min = 10250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_7" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.cp_nsg.id
  stateless = false
  description = "Allow TCP egress from workers to OKE control plane"
  tcp_options {
    destination_port_range {
      max = 12250
      min = 12250
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_worker_nsg_egress_8" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.worker_nsg.id
  protocol                  = "1"
  destination_type = "CIDR_BLOCK"
  destination = "0.0.0.0/0"
  stateless = false
  description = "Allow ICMP egress from workers for path discovery"
  icmp_options {
    type = 3
    code = 4
  }
}