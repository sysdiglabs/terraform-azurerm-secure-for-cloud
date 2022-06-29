output "container_registry" {
  value       = length(var.existing_registries) == 0 ? azurerm_container_registry.acr[0].name : local.registries[0].name
  description = "Azure Container Registry name"
}

output "container_registry_resource_group" {
  value       = length(var.existing_registries) == 0 ? var.resource_group_name : local.registries[0].resource_group
  description = "Azure Container Registry resource group"
}
