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

  set {
    name  = "azure.eventGridEventHubConnectionString"
    value = module.infrastructure_eventgrid_eventhub.azure_eventhub_connection_string
  }

  set {
    name  = "azure.tenantId"
    value = module.infrastructure_enterprise_app.tenant_id
  }

  set {
    name  = "azure.clientId"
    value = module.infrastructure_enterprise_app.client_id
  }

  set {
    name  = "azure.clientSecret"
    value = module.infrastructure_enterprise_app.client_secret
  }

  set {
    name  = "azure.region"
    value = var.location
  }

  values = [
    <<EOF
rules: []
ingestors:
 - azure-event-hub:
     subscriptionID: ${data.azurerm_subscription.current.subscription_id}
 - azure-event-grid:
     subscriptionID: ${data.azurerm_subscription.current.subscription_id}
scanners:
 - azure-acr : {}
 - azure-aci :
     subscriptionID : ${data.azurerm_subscription.current.subscription_id}
     resourceGroup : ${module.infrastructure_resource_group.resource_group_name}
     containerRegistry : ${module.infrastructure_container_registry.container_registry}
EOF
  ]
}
