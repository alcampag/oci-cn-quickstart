resource "oci_apigateway_certificate" "apigw_custom_tls_certificate" {
  certificate    = ""
  compartment_id = ""
  private_key    = ""
}

resource "oci_apigateway_gateway" "api_gw" {
  compartment_id = var.network_compartment_id
  endpoint_type  = var.apigw_private ? "PRIVATE" : "PUBLIC"
  subnet_id      = var.subnet_id
  display_name = var.apigw_name
  network_security_group_ids = [var.apigw_nsg_id]
  certificate_id = var.apigw_certificate_id
  ca_bundles {  # We need this to verify client certificates + to verify API Clients if mTlS is enabled in a deployment. The CA will be added in the APIGW Trust Store
    type = "CERTIFICATE_AUTHORITY"
    certificate_authority_id = var.apigw_certificate_authority_id
  }
}

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
        url = "http://${var.example_deployment_hostname}/api/v1/oke/$${request.path[service]}"
      }
    }
  }
  count = var.create_example_deployment ? 1 : 0
}