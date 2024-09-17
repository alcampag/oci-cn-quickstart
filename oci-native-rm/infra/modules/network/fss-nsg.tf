resource "oci_core_network_security_group" "fss_nsg" {
  compartment_id = var.network_compartment_id
  vcn_id         = oci_core_vcn.spoke_vcn.id
  display_name = "fss-nsg"
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_rule_1" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "17"  # UDP
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow UDP ingress for NFS portmapper from workers"
  udp_options {
    source_port_range {
      max = 111
      min = 111
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_rule_2" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow TCP ingress for NFS portmapper from workers"
  tcp_options {
    source_port_range {
      max = 111
      min = 111
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_rule_3" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "17"  # UDP
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow UDP ingress for NFS from workers"
  udp_options {
    source_port_range {
      max = 2048
      min = 2048
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_rule_4" {
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "6"
  source_type = "NETWORK_SECURITY_GROUP"
  source = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow TCP ingress for NFS from workers"
  tcp_options {
    source_port_range {
      max = 2050
      min = 2048
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_egress_rule_1" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "17"  # UDP
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow UDP egress for NFS portmapper to the workers"
  udp_options {
    source_port_range {
      max = 111
      min = 111
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_egress_rule_2" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow TCP egress for NFS portmapper to the workers"
  tcp_options {
    source_port_range {
      max = 111
      min = 111
    }
  }
  count = var.create_fss ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "fss_egress_rule_3" {
  direction                 = "EGRESS"
  network_security_group_id = oci_core_network_security_group.fss_nsg.0.id
  protocol                  = "6"
  destination_type = "NETWORK_SECURITY_GROUP"
  destination = oci_core_network_security_group.worker_nsg.id
  stateless = false
  description = "Allow TCP egress for NFS to the workers"
  tcp_options {
    source_port_range {
      max = 2050
      min = 2048
    }
  }
  count = var.create_fss ? 1 : 0
}


