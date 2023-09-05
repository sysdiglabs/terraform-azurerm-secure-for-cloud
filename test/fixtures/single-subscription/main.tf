provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "sysdig" {
  sysdig_secure_url       = var.sysdig_secure_endpoint
  sysdig_secure_api_token = var.sysdig_secure_api_token
}

module "s4c_single_account_example" {
  source = "../../../examples/single-subscription"

  name                    = "kitchen"
  deploy_scanning         = true
  deploy_benchmark        = false
  deploy_active_directory = false
}
