locals {
  eventgrid_eventhub_id        = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_id : ""
  registry_resource_group_name = var.registry_resource_group_name == "" ? module.infrastructure_resource_group.resource_group_name : var.registry_resource_group_name
}


module "infrastructure_enterprise_app" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/enterprise_app"

  name             = var.name
  subscription_ids = [data.azurerm_subscription.current.subscription_id]
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
