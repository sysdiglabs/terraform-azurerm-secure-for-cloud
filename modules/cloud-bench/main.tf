locals {

}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "azure_rg" {
  name = var.resource_group
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.naming_prefix}sa"
  resource_group_name      = data.azurerm_resource_group.azure_rg.name
  location                 = data.azurerm_resource_group.azure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "ss" {
  name                 = "${var.naming_prefix}-storage-ss"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 50
}

resource "azurerm_storage_share_file" "example" {
  name             = "cloud-bench.yaml"
  storage_share_id = azurerm_storage_share.ss.id
  source  = var.config_path
}

resource "azurerm_container_group" "aci" {
  name                = "${var.naming_prefix}-group"
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  ip_address_type     = "public"
  dns_name_label      = "cloud-bench"
  os_type             = "Linux"

  container {
    name   = "${var.naming_prefix}-container"
    image  = var.image
    cpu    = "1"
    memory = "2"

    ports {
      port     = 7000
      protocol = "TCP"
    }
  }

  tags = {
    Team = "Sysdig"
  }
}
