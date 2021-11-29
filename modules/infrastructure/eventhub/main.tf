locals {
  deploy_resource_group               = var.resource_group_name == ""
  resource_group_name                 = var.resource_group_name != "" ? var.resource_group_name : azurerm_resource_group.rg[0].name
  diagnostic_setting_subscription_ids = var.deploy_diagnostic_setting ? var.subscription_ids : []
}

resource "azurerm_resource_group" "rg" {
  count    = local.deploy_resource_group ? 1 : 0
  name     = "${lower(var.name)}-resourcegroup"
  location = var.location

  tags = var.tags
}


resource "random_string" "random" {
  length  = 5
  lower   = true
  upper   = false
  special = false
  number  = false
}

resource "azurerm_eventhub_namespace" "evn" {
  name                = "${lower(var.name)}-eventhub-namespace-${random_string.random.result}"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = var.sku
  capacity            = var.namespace_capacity

  tags = var.tags
}

resource "azurerm_eventhub_namespace_authorization_rule" "ns_auth_rule" {
  name                = "${lower(var.name)}-namespace-auth-rule"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  resource_group_name = local.resource_group_name

  listen = true
  send   = true
  manage = true
}

resource "azurerm_eventhub" "aev" {
  name                = "${lower(var.name)}-eventhub"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  resource_group_name = local.resource_group_name
  partition_count     = var.eventhub_partition_count
  message_retention   = var.eventhub_retention_days
}

resource "azurerm_eventhub_authorization_rule" "eh_auth_rule" {
  depends_on          = [azurerm_resource_group.rg]
  name                = "${lower(var.name)}-eventhub_auth_rule"
  namespace_name      = azurerm_eventhub_namespace.evn.name
  eventhub_name       = azurerm_eventhub.aev.name
  resource_group_name = local.resource_group_name

  listen = true
  send   = true
  manage = true
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  for_each                       = toset(local.diagnostic_setting_subscription_ids)
  name                           = "${lower(var.name)}-diagnostic_setting"
  target_resource_id             = "/subscriptions/${each.key}"
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.ns_auth_rule.id
  eventhub_name                  = azurerm_eventhub.aev.name

  lifecycle {
    ignore_changes = [log, metric]
  }

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
