resource "azurerm_storage_account" "sa" {
  name                      = "triggerazureevent"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  network_rules {
    default_action = "Allow"
  }
  allow_blob_public_access  = true
  enable_https_traffic_only = false
}
