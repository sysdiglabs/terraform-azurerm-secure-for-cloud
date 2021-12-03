
resource "azurerm_container_registry" "acr" {
  name                = "${lower(var.name)}containerregistry"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
}

resource "azurerm_eventgrid_event_subscription" "default" {
  name  = "${lower(var.name)}eventsubscription"
  scope = azurerm_container_registry.acr.id

  eventhub_endpoint_id = var.eventhub_endpoint_id

  included_event_types = ["Microsoft.ContainerRegistry.ImagePushed", "Microsoft.ContainerRegistry.ChartPushed"]
}
