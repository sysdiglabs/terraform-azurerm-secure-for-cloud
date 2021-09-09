
module "secure_for_cloud" {
  source = "sysdiglabs/secure-for-cloud/azurerm"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  resource_group_name     = var.resource_group_name
}
