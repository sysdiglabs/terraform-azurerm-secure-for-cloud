locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", var.sysdig_secure_endpoint)) != 0
}

module "infrastructure_eventhub" {
  source = "../../modules/infrastructure/eventhub"

  subscription_ids    = [data.azurerm_subscription.current.subscription_id]
  location            = var.location
  name                = var.name
  tags                = var.tags
  resource_group_name = var.resource_group_name
}
