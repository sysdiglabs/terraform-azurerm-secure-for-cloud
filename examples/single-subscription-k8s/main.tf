locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

module "infrastructure_resource_group" {
  source = "../../modules/infrastructure/resource_group"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids    = [data.azurerm_subscription.current.subscription_id]
  location            = var.location
  name                = var.name
  tags                = var.tags
  resource_group_name = module.infrastructure_resource_group.resource_group_name
}

module "infrastructure_eventgrid_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = [data.azurerm_subscription.current.subscription_id]
  location                  = var.location
  name                      = var.name
  tags                      = var.tags
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false
}

module "infrastructure_enterprise_app" {
  source = "../../modules/infrastructure/enterprise_app"

  name = var.name
}

module "infrastructure_container_registry" {
  source = "../../modules/infrastructure/container_registry"

  location             = var.location
  name                 = var.name
  resource_group_name  = module.infrastructure_resource_group.resource_group_name
  eventhub_endpoint_id = module.infrastructure_eventgrid_eventhub.azure_eventhub_id
}
