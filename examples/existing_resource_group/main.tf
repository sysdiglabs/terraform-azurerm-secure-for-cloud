
module "cloudvision" {
  source = "sysdiglabs/cloudvision/azurerm"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  resource_group_name     = var.resource_group_name
}
