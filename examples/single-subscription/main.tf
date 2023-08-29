locals {
  verify_ssl = length(regexall("^https://.*?\\.sysdig.com/?", data.sysdig_secure_connection.current.secure_url)) != 0
}

module "infrastructure_resource_group" {
  source = "../../modules/infrastructure/resource_group"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
