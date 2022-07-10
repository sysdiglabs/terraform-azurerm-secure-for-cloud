locals {
  tenant_id                            = data.azurerm_subscription.current.tenant_id
  verify_ssl                           = length(regexall("^https://.*?\\.sysdig.com/?", data.sysdig_secure_connection.current.secure_url)) != 0
  eventgrid_eventhub_connection_string = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_connection_string : ""
  eventgrid_eventhub_id                = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_id : ""
  container_registry                   = length(module.infrastructure_container_registry) > 0 ? module.infrastructure_container_registry[0].container_registry : ""
  client_id                            = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_id : ""
  client_secret                        = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_secret : ""
}

module "infrastructure_resource_group" {
  source = "../../modules/infrastructure/resource_group"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids             = local.threat_detection_subscription_ids
  location                     = var.location
  name                         = var.name
  tags                         = var.tags
  resource_group_name          = module.infrastructure_resource_group.resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory
}

module "infrastructure_eventgrid_eventhub" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = local.threat_detection_subscription_ids
  location                  = var.location
  name                      = var.name
  tags                      = var.tags
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false
}

module "infrastructure_container_registry" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/container_registry"

  location             = var.location
  name                 = var.name
  existing_registries  = var.existing_registries
  resource_group_name  = module.infrastructure_resource_group.resource_group_name
  eventhub_endpoint_id = local.eventgrid_eventhub_id
}

module "infrastructure_enterprise_app" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/enterprise_app"

  name             = var.name
  subscription_ids = local.threat_detection_subscription_ids
}

locals {
  available_subscriptions           = data.azurerm_subscriptions.available.subscriptions
  threat_detection_subscription_ids = length(var.threat_detection_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == local.tenant_id] : var.threat_detection_subscription_ids
}
