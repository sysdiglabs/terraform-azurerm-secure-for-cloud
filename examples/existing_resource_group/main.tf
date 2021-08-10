
provider "azurerm" {
  features {}
  subscription_id = "[SUBSCRIPTION_ID]"
}

module "cloudvision" {
  source = "../../"

  location = "[LOCATION]"

  sysdig_secure_api_token = "[SYSDIG_SECURE_API_TOKEN]"
  sysdig_secure_endpoint  = "[SYSDIG_SECURE_ENDPOINT]"
  resource_group_name     = "[RESOURCE_GROUP_NAME]"
}
