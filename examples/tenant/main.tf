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

  subscription_ids    = local.threat_detection_subscription_ids
  location            = var.location
  name                = var.name
  tags                = var.tags
  resource_group_name = module.infrastructure_resource_group.resource_group_name
}

module "infrastructure_eventgrid_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = local.threat_detection_subscription_ids
  location                  = var.location
  name                      = "${var.name}eventgrid"
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false
}

module "infrastructure_container_registry" {
  source = "../../modules/infrastructure/container_registry"

  location             = var.location
  name                 = var.name
  resource_group_name  = module.infrastructure_resource_group.resource_group_name
  eventhub_endpoint_id = module.infrastructure_eventgrid_eventhub.azure_eventhub_id
}

module "infrastructure_enterprise_app" {
  source = "../../modules/infrastructure/enterprise_app"

  name = var.name
}

module "cloud_connector" {
  source = "../../modules/services/cloud-connector"
  name   = "${var.name}-connector"

  subscription_ids                           = local.threat_detection_subscription_ids
  resource_group_name                        = module.infrastructure_resource_group.resource_group_name
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
}

locals {
  available_subscriptions           = data.azurerm_subscriptions.available.subscriptions
  benchmark_subscription_ids        = length(var.benchmark_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == var.tenant_id] : var.benchmark_subscription_ids
  threat_detection_subscription_ids = length(var.threat_detection_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == var.tenant_id] : var.threat_detection_subscription_ids
}

#######################
#      BENCHMARKS     #
#######################


provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
}

module "cloud_bench" {
  count  = var.deploy_bench ? 1 : 0
  source = "../../modules/services/cloud-bench"

  subscription_ids = local.benchmark_subscription_ids
  region           = var.region
  is_tenant        = true
}
