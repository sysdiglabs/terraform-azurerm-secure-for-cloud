locals {
  env_vars = {
    SECURE_URL                        = var.sysdig_secure_endpoint,
    SECURE_API_TOKEN                  = var.sysdig_secure_api_token,
    VERIFY_SSL                        = tostring(var.verify_ssl)
    CONFIG_PATH                       = "az://${azurerm_storage_account.sa.name}.blob.core.windows.net/${azurerm_storage_container.sc.name}/${azurerm_storage_blob.sb.name}"
    AZURE_EVENT_HUB_CONNECTION_STRING = var.azure_eventhub_connection_string
    AZURE_STORAGE_ACCOUNT             = azurerm_storage_account.sa.name
    AZURE_STORAGE_ACCESS_KEY          = azurerm_storage_account.sa.primary_access_key
    AZURE_REGION                      = var.location
  }

  default_config = <<EOF
  rules:
    - directory:
        path: ./rules
  ingestors:
    - azure-event-hub:
        subscriptionID: ${var.subscription_id}
  notifiers: []
  EOF
  config_content = var.config_content == null && var.config_source == null ? local.default_config : var.config_content
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.naming_prefix}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "sn" {
  name                                           = "${var.naming_prefix}-vn"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vn.name
  address_prefixes                               = ["10.0.2.0/24"]
  service_endpoints                              = ["Microsoft.ContainerRegistry"]
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
  resource_group_name = var.resource_group_name

  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "sc" {
  name                 = "${var.naming_prefix}-sc"
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_blob" "sb" {
  name                   = "cloud-connector.yml"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type                   = "Block"
  source_content         = local.config_content
  source                 = var.config_source
}

resource "azurerm_network_profile" "np" {
  name                = "${var.naming_prefix}-script"
  location            = var.location
  resource_group_name = var.resource_group_name

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
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.np.id

  container {
    name   = "${var.naming_prefix}-container"
    image  = var.image
    cpu    = "1"
    memory = "2"

    environment_variables = local.env_vars

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = var.tags
}
