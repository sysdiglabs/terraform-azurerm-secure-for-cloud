locals {
  verify_ssl                           = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
  eventgrid_eventhub_connection_string = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_connection_string : ""
  eventgrid_eventhub_id                = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_id : ""
  container_registry                   = length(module.infrastructure_container_registry) > 0 ? module.infrastructure_container_registry[0].container_registry : ""
  tenant_id                            = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].tenant_id : ""
  client_id                            = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_id : ""
  client_secret                        = length(module.infrastructure_enterprise_app) > 0 ? module.infrastructure_enterprise_app[0].client_secret : ""
  registry_resource_group_name         = var.registry_resource_group_name == "" ? module.infrastructure_resource_group.resource_group_name : var.registry_resource_group_name
}

module "infrastructure_resource_group" {
  source = "../../modules/infrastructure/resource_group"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids             = [data.azurerm_subscription.current.subscription_id]
  location                     = var.location
  name                         = var.name
  tags                         = var.tags
  resource_group_name          = module.infrastructure_resource_group.resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory
}

module "infrastructure_eventgrid_eventhub" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = [data.azurerm_subscription.current.subscription_id]
  location                  = var.location
  name                      = var.name
  tags                      = var.tags
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false
}

module "infrastructure_enterprise_app" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/enterprise_app"

  name = var.name
}

module "infrastructure_container_registry" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/container_registry"

  location             = var.location
  name                 = var.name
  registry_name        = var.registry_name
  resource_group_name  = local.registry_resource_group_name
  eventhub_endpoint_id = local.eventgrid_eventhub_id
}
