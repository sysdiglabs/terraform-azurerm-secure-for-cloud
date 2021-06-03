locals {

}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "azure_rg" {
  name = var.resource_group
}

resource "azurerm_virtual_network" "vn" {
  name                 = "${var.naming_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}

resource "azurerm_subnet" "aci" {
  name                                           = "${var.naming_prefix}-aci"
  resource_group_name                            = data.azurerm_resource_group.azure_rg.name
  virtual_network_name                           = azurerm_virtual_network.vn.name
  address_prefixes                               = ["10.0.1.0/24"]
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
  delegation {
    name   = "${var.naming_prefix}-delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "aci_profile" {
  name                = "${var.naming_prefix}-profile"
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name

  container_network_interface {
    name = "${var.naming_prefix}-net-interface"

    ip_configuration {
      name = "${var.naming_prefix}-ip-conf"
      subnet_id = azurerm_subnet.aci.id
    }
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.naming_prefix}sa"
  resource_group_name      = data.azurerm_resource_group.azure_rg.name
  location                 = data.azurerm_resource_group.azure_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.aci.id]
    ip_rules                   = ["100.0.0.1"]
  }
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
  ip_address_type     = "private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.aci_profile.id


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
