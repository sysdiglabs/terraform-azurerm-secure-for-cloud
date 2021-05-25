output "removeme" {
  value       = data.azurerm_lb.dummy.name
  description = "Added only to create initial pipeline"
}
