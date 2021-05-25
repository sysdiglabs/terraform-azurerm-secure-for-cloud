
# TODO: Remove this, was created only to setup initial CI pipeline
data "azurerm_lb" "dummy" {
  name                = "removeme"
  resource_group_name = "removeme"
}
