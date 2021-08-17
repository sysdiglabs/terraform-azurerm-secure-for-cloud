
module "cloudvision" {
  source = "sysdiglabs/cloudvision/azurerm"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  sysdig_secure_endpoint  = "https://secure.sysdig.com"
}
