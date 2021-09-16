locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

#######################
#      BENCHMARKS     #
#######################

provider "sysdig" {
  sysdig_secure_url          = var.sysdig_secure_endpoint
  sysdig_secure_api_token    = var.sysdig_secure_api_token
  sysdig_secure_insecure_tls = !local.verify_ssl
}

provider "azurerm" {
  features {}
}

module "cloud_bench" {
  source          = "../../modules/services/cloud-bench"
  subscription_id = var.subscription_id
}
