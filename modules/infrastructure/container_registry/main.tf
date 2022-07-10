locals {
  deploy_container_registry = length(var.existing_registries) == 0
  existing_registries = distinct(flatten([
    for resource_group, registry_names in var.existing_registries : [
      for registry_name in registry_names : {
        resource_group = resource_group
        name           = registry_name
      }
    ]
  ]))
  registries = length(var.existing_registries) == 0 ? [] : local.existing_registries
  data_registry_ids = distinct(flatten([
    for entry in data.azurerm_container_registry.example : [
      {
        id   = entry.id
        name = entry.name
      }
    ]
  ]))
}

resource "random_string" "random" {
  length  = 5
  lower   = true
  upper   = false
  special = false
}

resource "azurerm_container_registry" "acr" {
  count               = local.deploy_container_registry ? 1 : 0
  name                = "containerregistry${lower(var.name)}${random_string.random.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
}

data "azurerm_container_registry" "example" {
  for_each            = { for entry in local.registries : "${entry.resource_group}.${entry.name}" => entry }
  name                = local.deploy_container_registry ? azurerm_container_registry.acr[0].name : each.value.name
  resource_group_name = each.value.resource_group
}

data "azurerm_container_registry" "new" {
  count               = local.deploy_container_registry ? 1 : 0
  name                = azurerm_container_registry.acr[0].name
  resource_group_name = var.resource_group_name

}

resource "azurerm_eventgrid_event_subscription" "new" {
  count = local.deploy_container_registry ? 1 : 0
  name  = "${lower(var.name)}eventsubscription"
  scope = data.azurerm_container_registry.new[0].id

  eventhub_endpoint_id = var.eventhub_endpoint_id

  included_event_types = ["Microsoft.ContainerRegistry.ImagePushed", "Microsoft.ContainerRegistry.ChartPushed"]
}

resource "azurerm_eventgrid_event_subscription" "default" {
  for_each = { for entry in local.data_registry_ids : "${entry.id}.${entry.name}" => entry }
  name     = "${each.value.name}eventsubscription"
  scope    = each.value.id

  eventhub_endpoint_id = var.eventhub_endpoint_id

  included_event_types = ["Microsoft.ContainerRegistry.ImagePushed", "Microsoft.ContainerRegistry.ChartPushed"]
}
