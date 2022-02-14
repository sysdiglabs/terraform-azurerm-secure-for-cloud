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

provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
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
  resource_group_name          = module.infrastructure_resource_group.resource_group_name
  deploy_ad_diagnostic_setting = var.deploy_active_directory
}

module "infrastructure_eventgrid_eventhub" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = [data.azurerm_subscription.current.subscription_id]
  location                  = var.location
  name                      = "${var.name}eventgrid"
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false
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

module "infrastructure_enterprise_app" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/enterprise_app"

  name             = var.name
  subscription_ids = [data.azurerm_subscription.current.subscription_id]
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  deploy_scanning                            = var.deploy_scanning
  resource_group_name                        = module.infrastructure_resource_group.resource_group_name
  container_registry                         = local.container_registry
  azure_eventhub_connection_string           = module.infrastructure_eventhub.azure_eventhub_connection_string
  azure_eventgrid_eventhub_connection_string = local.eventgrid_eventhub_connection_string
  tenant_id                                  = local.tenant_id
  client_id                                  = local.client_id
  client_secret                              = local.client_secret
  location                                   = var.location
  sysdig_secure_api_token                    = var.sysdig_secure_api_token
  sysdig_secure_endpoint                     = var.sysdig_secure_endpoint
  verify_ssl                                 = local.verify_ssl
  cpu                                        = var.cpu
  memory                                     = var.memory
  tags                                       = var.tags
  subscription_id                            = data.azurerm_subscription.current.subscription_id
}
