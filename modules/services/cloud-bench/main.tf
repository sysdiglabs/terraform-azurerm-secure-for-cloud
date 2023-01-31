data "azurerm_subscription" "current" {}
data "azurerm_subscriptions" "available" {}

locals {
  # List all available subscriptions
  available_subscriptions = data.azurerm_subscriptions.available.subscriptions

  # If a list of subscriptions is provided, use that. Otherwise, use all available subscriptions that match the current tenant.
  in_scope_subscription_ids = length(var.subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == data.azurerm_subscription.current.tenant_id] : var.subscription_ids

  # If we are performing a single subscription install, ignore the list of all subsc
  subscription_ids = var.is_tenant ? local.in_scope_subscription_ids : [var.subscription_id]
}

module "trust_relationship" {
  for_each = toset(local.subscription_ids)
  source   = "./trust_relationship"

  subscription_id = each.key
}

module "task" {
  source = "./task"

  subscription_id  = var.subscription_id
  subscription_ids = local.subscription_ids
  is_tenant        = var.is_tenant
  region           = var.region

  depends_on = [module.trust_relationship]
}
