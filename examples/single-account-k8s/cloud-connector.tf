resource "helm_release" "cloud_connector" {
  name = "cloud-connector"

  repository = "https://charts.sysdig.com"
  chart      = "cloud-connector"

  create_namespace = true
  namespace        = var.name
  atomic           = true
  timeout          = 60

  set_sensitive {
    name  = "sysdig.secureAPIToken"
    value = var.sysdig_secure_api_token
  }

  set {
    name  = "sysdig.url"
    value = var.sysdig_secure_endpoint
  }

  set {
    name  = "sysdig.verifySSL"
    value = local.verify_ssl
  }

  set {
    name  = "image.repository"
    value = var.cloud_connector_image
  }

  set {
    name  = "azure.eventHubConnectionString"
    value = module.infrastructure_eventhub.azure_eventhub_connection_string
  }

  values = [
    <<EOF
rules: []
ingestors:
 - azure-event-hub:
     subscriptionID: ${var.subscription_id}
notifiers: []
EOF
  ]
}
