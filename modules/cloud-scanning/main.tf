locals {

}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "azure_rg" {
  name = var.resource_group
}

resource "azurerm_container_group" "aci" {
  name                = "${var.naming_prefix}-group"
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  ip_address_type     = "public"
  dns_name_label      = "cloud-scanning"
  os_type             = "Linux"

  container {
    name   = "${var.naming_prefix}-container"
    image  = var.image
    cpu    = "1"
    memory = "2"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = {
    Team = "Sysdig"
  }
}
