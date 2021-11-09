module "s4c_single_account_example" {
  source = "../../../examples/single-account"

  subscription_id         = var.subscription_id
  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchen"
  deploy_bench            = false
}
