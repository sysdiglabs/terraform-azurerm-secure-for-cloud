locals {
  deploy_container_registry = var.registry_name == ""
}

resource "azurerm_container_registry" "acr" {
  count               = local.deploy_container_registry ? 1 : 0
  name                = "${lower(var.name)}containerregistry"
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
