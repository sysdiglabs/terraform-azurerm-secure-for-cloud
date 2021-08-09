output "resource_group_name" {
  value       = azurerm_resource_group.rg[0].name
  description = "Created resources group name"
}

output "eventhub_connection_string" {
  value       = azurerm_eventhub_authorization_rule.eh_auth_rule.primary_connection_string
  description = "EventHub SAS policy connection string"
  sensitive   = true
}
