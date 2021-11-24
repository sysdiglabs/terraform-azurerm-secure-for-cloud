module "cloud_bench" {
  count           = var.deploy_benchmark ? 1 : 0
  source          = "../../modules/services/cloud-bench"
  subscription_id = data.azurerm_subscription.current.id
  region          = var.region
}
