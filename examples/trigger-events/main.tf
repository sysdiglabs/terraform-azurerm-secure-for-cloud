resource "random_string" "random" {
  length  = 5
  lower   = true
  upper   = false
  special = false
  number  = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "triggerazureevent${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action = "Allow"
  }
  allow_nested_items_to_be_public  = true
  enable_https_traffic_only = false
}
