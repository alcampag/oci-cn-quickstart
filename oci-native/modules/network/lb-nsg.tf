resource "oci_core_network_security_group" "oke_lb_nsg" {
  compartment_id = var.network_compartment_id
  vcn_id         = module.oke-network.vcn_id
  display_name = "oke-lb-nsg"
}

resource "oci_core_network_security_group_security_rule" "oke_lb_nsg_rule_workers_egress" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.oke_lb_nsg
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = module.oke-network.worker_nsg_id
  stateless = true
  description = "Allow TCP traffic from load balancer to worker nodes for services of type NodePort - stateless Egress"
  tcp_options {
    destination_port_range {
      max = 32767
      min = 30000
    }
  }
}

resource "oci_core_network_security_group_security_rule" "oke_lb_nsg_rule_workers_ingress" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.oke_lb_nsg
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = module.oke-network.worker_nsg_id
  stateless = true
  description = "Allow TCP traffic from worker nodes to load balancer for services of type NodePort - stateless Ingress"
  tcp_options {
    source_port_range {
      max = 32767
      min = 30000
    }
  }
}