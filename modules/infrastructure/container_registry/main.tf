locals {
  georeplication_collection = [
    for location in toset(var.georeplication) : {
      location                = location
      zone_redundancy_enabled = true
      tags                    = {}
    }
  ]
  georeplication = var.sku != "Premium" ? [] : local.georeplication_collection
}

resource "azurerm_container_registry" "acr" {
  name                = "${lower(var.naming_prefix)}containerregistry"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  georeplications     = local.georeplication
}

resource "azurerm_eventgrid_event_subscription" "default" {
  name  = "${lower(var.naming_prefix)}eventsubscription"
  scope = azurerm_container_registry.acr.id

  eventhub_endpoint_id = var.eventhub_endpoint_id

  included_event_types = ["Microsoft.ContainerRegistry.ImagePushed", "Microsoft.ContainerRegistry.ChartPushed"]
}
