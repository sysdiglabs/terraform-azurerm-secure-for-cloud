locals {
  eventgrid_eventhub_connection_string = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_connection_string : ""
  eventgrid_eventhub_id                = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_id : ""

  available_subscriptions           = data.azurerm_subscriptions.available.subscriptions
  threat_detection_subscription_ids = length(var.threat_detection_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == local.tenant_id] : var.threat_detection_subscription_ids

  tenant_id     = data.azurerm_subscription.current.tenant_id
  client_id     = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_id : ""
  client_secret = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_secret : ""
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"
  name   = var.name

  subscription_ids             = local.threat_detection_subscription_ids
  location                     = var.location
  resource_group_name          = module.infrastructure_resource_group.resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory

  tags = var.tags
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  is_organizational   = true
  subscription_id     = data.azurerm_subscription.current.subscription_id
  resource_group_name = module.infrastructure_resource_group.resource_group_name

  deploy_scanning                            = var.deploy_scanning
  container_registry                         = local.container_registry
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
}
