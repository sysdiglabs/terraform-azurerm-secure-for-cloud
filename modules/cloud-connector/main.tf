locals {
  env_vars = {
    SECURE_URL                  = var.sysdig_secure_endpoint,
    SECURE_API_TOKEN            = var.sysdig_secure_api_token,
    VERIFY_SSL                  = tostring(var.verify_ssl)
    CONFIG_PATH                 = "${var.config_path}${var.config_file}"
    EVENT_HUB_CONNECTION_STRING = var.event_hub_connection_string
  }
}

module "base_infrastructure" {
  source = "../base-infrastructure"

  subscription_id = var.subscription_id
  naming_prefix   = "cloudconnector"
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.naming_prefix}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = module.base_infrastructure.resource_group_location
  resource_group_name = module.base_infrastructure.resource_group_name
}

resource "azurerm_subnet" "sn" {
  name                                           = "${var.naming_prefix}-vn"
  resource_group_name                            = module.base_infrastructure.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vn.name
  address_prefixes                               = ["10.0.2.0/24"]
  service_endpoints                              = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true

  delegation {
    name = "${var.naming_prefix}-delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_storage_account" "sa" {
  name                = "${var.naming_prefix}sa"
  resource_group_name = module.base_infrastructure.resource_group_name

  location                 = module.base_infrastructure.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Team = "Sysdig"
  }
}

resource "azurerm_storage_share" "container_share" {
  name                 = "${var.naming_prefix}-share"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 1
}

resource "azurerm_storage_share_file" "sf" {
  name             = "cloud-connector.yml"
  storage_share_id = azurerm_storage_share.container_share.id
  source           = var.config_file
}

resource "azurerm_network_profile" "np" {
  name                = "${var.naming_prefix}-script"
  location            = module.base_infrastructure.resource_group_location
  resource_group_name = module.base_infrastructure.resource_group_name

  container_network_interface {
    name = "${var.naming_prefix}-ni"

    ip_configuration {
      name      = "acrfrontal"
      subnet_id = azurerm_subnet.sn.id
    }
  }
}

resource "azurerm_container_group" "cg" {
  name                = "${var.naming_prefix}-group"
  location            = module.base_infrastructure.resource_group_location
  resource_group_name = module.base_infrastructure.resource_group_name
  ip_address_type     = "private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.np.id

  container {
    name   = "${var.naming_prefix}-container"
    image  = var.image
    cpu    = "1"
    memory = "2"

    volume {
      name                 = "${var.naming_prefix}-vol"
      read_only            = true
      mount_path           = var.config_path
      share_name           = azurerm_storage_share.container_share.name
      storage_account_name = azurerm_storage_account.sa.name
      storage_account_key  = azurerm_storage_account.sa.primary_access_key
    }
    environment_variables = local.env_vars

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = {
    Team = "Sysdig"
  }
}
