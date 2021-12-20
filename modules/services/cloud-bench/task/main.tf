###################################################
# Fetch & compute required data
###################################################

data "azurerm_subscription" "subscription" {
  subscription_id = var.is_tenant ? var.subscription_ids[0] : var.subscription_id
}

data "azurerm_subscriptions" "available" {
}

locals {
  benchmark_task_name   = var.is_tenant ? "Tenant: ${data.azurerm_subscriptions.available.subscriptions[0].tenant_id}" : data.azurerm_subscription.subscription.display_name
  accounts_scope_clause = var.is_tenant ? "azure.subscriptionId in (\"${join("\", \"", var.subscription_ids)}\")" : "azure.subscriptionId = \"${var.subscription_id}\""
  regions_scope_clause  = length(var.region) == 0 ? "" : " and azure.region = \"${var.region}\""
}

###################################################
# Configure Sysdig Backend
###################################################

resource "random_integer" "minute" {
  max = 59
  min = 0
}

resource "random_integer" "hour" {
  max = 23
  min = 0
}

resource "sysdig_secure_benchmark_task" "benchmark_task" {
  name     = "Sysdig Secure for Cloud (Azure) - ${local.benchmark_task_name}"
  schedule = "${random_integer.minute.result} ${random_integer.hour.result} * * *"
  schema   = "azure_foundations_bench-1.3.0"
  scope    = "${local.accounts_scope_clause}${local.regions_scope_clause}"
}
