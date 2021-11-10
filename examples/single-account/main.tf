locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
}

data "azurerm_subscription" "current" {
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids    = [data.azurerm_subscription.current.subscription_id]
  location            = var.location
  name                = var.name
  tags                = var.tags
  resource_group_name = var.resource_group_name
}

module "infrastructure_eventgrid_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_id           = data.azurerm_subscription.current.subscription_id
  location                  = var.location
  name                      = "${var.name}eventgrid"
  resource_group_name       = module.infrastructure_eventhub.resource_group_name
  deploy_diagnostic_setting = false
}

module "infrastructure_container_registry" {
  source = "../../modules/infrastructure/container_registry"

  location             = var.location
  name                 = var.name
  resource_group_name  = module.infrastructure_eventhub.resource_group_name
  eventhub_endpoint_id = module.infrastructure_eventgrid_eventhub.azure_eventhub_id
}

module "infrastructure_enterprise_app" {
  source = "../../modules/infrastructure/enterprise_app"

  name            = var.name
  subscription_id = data.azurerm_subscription.current.subscription_id
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  resource_group_name                        = module.infrastructure_eventhub.resource_group_name
  container_registry                         = module.infrastructure_container_registry.container_registry
  azure_eventhub_connection_string           = module.infrastructure_eventhub.azure_eventhub_connection_string
  azure_eventgrid_eventhub_connection_string = module.infrastructure_eventgrid_eventhub.azure_eventhub_connection_string
  tenant_id                                  = module.infrastructure_enterprise_app.tenant_id
  client_id                                  = module.infrastructure_enterprise_app.client_id
  client_secret                              = module.infrastructure_enterprise_app.client_secret
  location                                   = var.location
  sysdig_secure_api_token                    = var.sysdig_secure_api_token
  sysdig_secure_endpoint                     = var.sysdig_secure_endpoint
  verify_ssl                                 = local.verify_ssl
  tags                                       = var.tags
  subscription_ids                           = [data.azurerm_subscription.current.subscription_id]
}

module "cloud_bench" {
  count           = var.deploy_bench ? 1 : 0
  source          = "../../modules/services/cloud-bench"
  subscription_id = var.subscription_id
  region          = var.region
}
