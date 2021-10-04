locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

data "azurerm_subscriptions" "available" {
}


#######################
#      BENCHMARKS     #
#######################

locals {
  available_subscriptions    = data.azurerm_subscriptions.available.subscriptions
  benchmark_subscription_ids = length(var.benchmark_subscription_ids) == 0 ? [for s in local.available_subscriptions : s.subscription_id if s.tenant_id == var.tenant_id] : var.benchmark_subscription_ids
}

provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
}

provider "azurerm" {
  features {}
}

module "cloud_bench" {
  source = "../../modules/services/cloud-bench"

  subscription_ids = local.benchmark_subscription_ids
  region           = var.region
  is_tenant        = true
}
