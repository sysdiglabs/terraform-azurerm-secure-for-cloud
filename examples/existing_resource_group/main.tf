
provider "azurerm" {
  features {}
  subscription_id = "00000000-1111-2222-3333-444444444444"
}

module "cloudvision" {
  source = "sysdiglabs/cloudvision/azurerm"

  sysdig_secure_api_token = "11111111-2222-3333-4444-555555555555"
  sysdig_secure_endpoint  = "https://secure.sysdig.com"
  resource_group_name     = "[EXISTING_RESOURCE_GROUP_NAME]"
}
