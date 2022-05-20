locals {
  available_subscriptions    = data.azurerm_subscriptions.available.subscriptions
  benchmark_subscription_ids = length(var.benchmark_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == local.tenant_id] : var.benchmark_subscription_ids
}

module "cloud_bench" {
  count  = var.deploy_benchmark ? 1 : 0
  source = "../../modules/services/cloud-bench"

  subscription_ids = local.benchmark_subscription_ids
  region           = var.region
  is_tenant        = true
}
