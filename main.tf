# Configure the Azure provider

resource "azurerm_resource_group" "rg" {
  name     = "resourceterraform"
  location = "westus2"

  tags = {
    Team = "sysdig"
  }
}

resource "azurerm_eventhub_namespace" "evn" {
  name                = "egi-terraform-namespace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  capacity            = 2

  tags = {
    Team = "sysdig"
  }
}

resource "azurerm_eventhub_namespace_authorization_rule" "ns_auth_rule" {
  name                = "egiSharedAccessKey"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  resource_group_name = azurerm_resource_group.rg.name

  listen = true
  send   = true
  manage = true
}

resource "azurerm_eventhub" "aev" {
  name                = "terraformEventHub"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "example" {
  name                = "navi"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  eventhub_name       = azurerm_eventhub.aev.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = true
  send                = true
  manage              = true
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  for_each = var.targets_map

  name                           = "tf-egi-diag"
  target_resource_id             = each.key
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.ns_auth_rule.id
  eventhub_name                  = "terraformeventhub"

  dynamic "log" {
    for_each = var.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }
}
