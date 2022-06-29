locals {
  eventgrid_eventhub_id = length(module.infrastructure_eventgrid_eventhub) > 0 ? module.infrastructure_eventgrid_eventhub[0].azure_eventhub_id : ""
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

  name                      = "${var.name}eventgrid"
  subscription_ids          = [data.azurerm_subscription.current.subscription_id]
  location                  = var.location
  resource_group_name       = module.infrastructure_resource_group.resource_group_name
  deploy_diagnostic_setting = false

  tags = var.tags
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
