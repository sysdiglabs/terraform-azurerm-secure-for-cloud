locals {
  container_registry           = length(module.infrastructure_container_registry) > 0 ? module.infrastructure_container_registry[0].container_registry : ""
  registry_resource_group_name = var.registry_resource_group_name == "" ? module.infrastructure_resource_group.resource_group_name : var.registry_resource_group_name
}


module "infrastructure_eventgrid_eventhub" {
  count  = var.deploy_scanning ? 1 : 0
  source = "../../modules/infrastructure/eventhub"

  subscription_ids          = local.threat_detection_subscription_ids
  location                  = var.location
  name                      = "${var.name}eventgrid"
  tags                      = var.tags
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
  subscription_ids = local.threat_detection_subscription_ids
}
