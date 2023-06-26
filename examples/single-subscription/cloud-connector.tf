locals {
  tenant_id     = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].tenant_id : ""
  client_id     = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_id : ""
  client_secret = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_secret : ""

  eventgrid_eventhub_connection_string = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_connection_string : ""
  container_registries                 = length(module.infrastructure_container_registry) > 0 ? module.infrastructure_container_registry[0].container_registry : ""
}


module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"
  name   = var.name

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]
  location                     = var.location
  resource_group_name          = module.infrastructure_resource_group.resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory

  tags = var.tags
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  subscription_id     = data.azurerm_subscription.current.subscription_id
  resource_group_name = module.infrastructure_resource_group.resource_group_name

  deploy_scanning                            = var.deploy_scanning
  container_registry                         = local.container_registries
  azure_eventhub_connection_string           = module.infrastructure_eventhub.azure_eventhub_connection_string
  azure_eventgrid_eventhub_connection_string = local.eventgrid_eventhub_connection_string

  tenant_id     = local.tenant_id
  client_id     = local.client_id
  client_secret = local.client_secret
  location      = var.location

  sysdig_secure_api_token = data.sysdig_secure_connection.current.secure_api_token
  sysdig_secure_endpoint  = data.sysdig_secure_connection.current.secure_url
  verify_ssl              = local.verify_ssl

  cpu    = var.cpu
  memory = var.memory

  tags = var.tags
  logging = var.logging
}
