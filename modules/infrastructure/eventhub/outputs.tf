
output "azure_eventhub_connection_string" {
  value       = azurerm_eventhub_authorization_rule.eh_auth_rule.primary_connection_string
  description = "EventHub SAS policy connection string"
  sensitive   = true
}

output "azure_eventhub_id" {
  value       = azurerm_eventhub.aev.id
  description = "EventHub ID"
  sensitive   = true
}
