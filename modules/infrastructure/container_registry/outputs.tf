output "container_registry" {
  value       = length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].name : var.registry_name
  description = "Azure Container Registry name"
}
