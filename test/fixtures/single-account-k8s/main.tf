module "s4c_single_account_k8s_example" {
  source = "../../../examples/single-account-k8s"

  subscription_id         = var.subscription_id
  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchen"
  deploy_bench            = false
}
