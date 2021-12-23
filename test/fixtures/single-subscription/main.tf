provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "s4c_single_account_example" {
  source = "../../../examples/single-subscription"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchen"
  deploy_benchmark        = false
  deploy_active_directory = false
}
