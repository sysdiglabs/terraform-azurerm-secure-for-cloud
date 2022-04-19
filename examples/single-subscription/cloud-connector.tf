locals {
  tenant_id     = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].tenant_id : ""
  client_id     = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_id : ""
  client_secret = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_secret : ""

  eventgrid_eventhub_connection_string = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_connection_string : ""
  container_registry                   = length(module.infrastructure_container_registry) > 0 ? module.infrastructure_container_registry[0].container_registry : ""
}



module "infrastructure_eventhub" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/infrastructure/eventhub"

  subscription_ids             = [data.azurerm_subscription.current.subscription_id]
  location                     = var.location
  name                         = var.name
  resource_group_name          = module.infrastructure_resource_group[0].resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory
}

module "cloud_connector" {
  count = var.deploy_cloud_connector_module ? 1 : 0

  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  subscription_id     = data.azurerm_subscription.current.subscription_id
  resource_group_name = module.infrastructure_resource_group[0].resource_group_name
  tenant_id           = local.tenant_id
  client_id           = local.client_id
  client_secret       = local.client_secret
  location            = var.location

  sysdig_secure_api_token = var.sysdig_secure_api_token
  sysdig_secure_endpoint  = var.sysdig_secure_endpoint
  verify_ssl              = local.verify_ssl

  azure_eventhub_connection_string = module.infrastructure_eventhub[0].azure_eventhub_connection_string
  cpu                              = var.cpu
  memory                           = var.memory

  deploy_scanning                            = var.deploy_scanning
  container_registry                         = local.container_registry
  azure_eventgrid_eventhub_connection_string = local.eventgrid_eventhub_connection_string

  tags = var.tags
}
