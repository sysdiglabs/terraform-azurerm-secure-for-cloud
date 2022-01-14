locals {
  deploy_container_registry = var.registry_name == ""
}

resource "random_string" "random" {
  length  = 5
  lower   = true
  upper   = false
  special = false
  number  = false
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
  name                = local.deploy_container_registry ? azurerm_container_registry.acr[0].name : var.registry_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventgrid_event_subscription" "default" {
  name  = "${lower(var.name)}eventsubscription"
  scope = data.azurerm_container_registry.example.id

  eventhub_endpoint_id = var.eventhub_endpoint_id

  included_event_types = ["Microsoft.ContainerRegistry.ImagePushed", "Microsoft.ContainerRegistry.ChartPushed"]
}
