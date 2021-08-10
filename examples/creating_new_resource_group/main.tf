provider "azurerm" {
  features {}
  subscription_id = "[SUBSCRIPTION_ID]"
}

module "cloudvision" {
  source = "../../"

  location                = "[LOCATION]"
  naming_prefix           = "cloudvision"
  sysdig_secure_api_token = "[SYSDIG_SECURE_API_TOKEN]"
  sysdig_secure_endpoint  = "[SYSDIG_SECURE_ENDPOINT]"
}
