locals {
  deploy_resource_group = var.resource_group_name == ""
}

resource "azurerm_resource_group" "rg" {
  # AC_AZURE_0389
  # Why: Terrascan doesn't seem to be able to render the fix
  #ts:skip=AC_AZURE_0389 Already fixed but terrascan doesn't seem to be able to render it
  count    = local.deploy_resource_group ? 1 : 0
  name     = "${lower(var.name)}-resourcegroup"
  location = var.location

  tags = var.tags
}

resource "azurerm_management_lock" "resource_group_lock" {
  name       = "${lower(var.name)}-resource-group-lock"
  scope      = azurerm_resource_group.rg[0].id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}
