locals {
  deploy_cloudconnector = var.cloudconnector_deploy
  verify_ssl            = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

module "cloud_connector" {
  count  = local.deploy_cloudconnector ? 1 : 0
  source = "./modules/cloud-connector"

  naming_prefix               = var.naming_prefix
  location                    = var.location
  sysdig_secure_api_token     = var.sysdig_secure_api_token
  sysdig_secure_endpoint      = var.sysdig_secure_endpoint
  verify_ssl                  = local.verify_ssl
  event_hub_connection_string = var.event_hub_connection_string
  subscription_id             = var.subscription_id
}
