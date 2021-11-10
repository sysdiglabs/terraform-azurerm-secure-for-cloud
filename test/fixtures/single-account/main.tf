provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "cloudvision_example_existing_resource_group" {
  source = "../../../examples/single-account"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "hayk"
  deploy_bench            = false
}
