resource "oci_apigateway_gateway" "api_gw" {
  compartment_id = var.network_compartment_id
  endpoint_type  = var.apigw_private ? "PRIVATE" : "PUBLIC"
  subnet_id      = oci_core_subnet.service_subnet.id
  display_name = "apigw-quickstart"
  network_security_group_ids = [oci_core_network_security_group.apigw_nsg.id]
}

# Forward all /api/oke to lb-host/api
resource "oci_apigateway_deployment" "apigw_oke_deployment" {
  display_name = "api-v1"
  compartment_id = var.network_compartment_id
  gateway_id     = oci_apigateway_gateway.api_gw.id
  path_prefix    = "/api/v1"
  specification {
    routes {
      path = "/oke/{service}"
      methods = ["ANY"]
      backend {
        type = "HTTP_BACKEND"
        url = "http://${local.test_hostname_ingress}/api/v1/oke/$${request.path[service]}"
      }
    }
  }
}