module "cloud_bench" {
  count  = var.deploy_benchmark ? 1 : 0
  source = "../../modules/services/cloud-bench"

  subscription_ids = var.benchmark_subscription_ids
  is_tenant        = true
}
