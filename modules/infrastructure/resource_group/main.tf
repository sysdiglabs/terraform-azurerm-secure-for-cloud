locals {
  deploy_resource_group = var.resource_group_name == ""
}

resource "azurerm_resource_group" "rg" {
  # AC_AZURE_0389
  #ts:skip=AC_AZURE_0389 Blocking resources on customer infra lays outside Sysdigs scope
  count    = local.deploy_resource_group ? 1 : 0
  name     = "${lower(var.name)}-resourcegroup"
  location = var.location
  tags     = var.tags
}
