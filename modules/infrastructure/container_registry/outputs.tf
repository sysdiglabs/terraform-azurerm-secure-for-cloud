output "container_registry" {
  value       = azurerm_container_registry.acr.name
  description = "Created container registry name"
}
