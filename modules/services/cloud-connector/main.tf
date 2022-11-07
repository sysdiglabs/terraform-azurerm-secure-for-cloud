locals {
  suffix_org = var.is_organizational ? "org" : "single"
  env_vars = {
    SECURE_URL                                  = var.sysdig_secure_endpoint,
    SECURE_API_TOKEN                            = var.sysdig_secure_api_token,
    TELEMETRY_DEPLOYMENT_METHOD                 = "terraform_azure_aci_${local.suffix_org}"
    VERIFY_SSL                                  = tostring(var.verify_ssl)
    CONFIG                                      = base64encode(local.config_content)
    AZURE_EVENT_HUB_CONNECTION_STRING           = var.azure_eventhub_connection_string
    AZURE_EVENTGRID_EVENT_HUB_CONNECTION_STRING = var.azure_eventgrid_eventhub_connection_string
    AZURE_REGION                                = var.location
    CONFIG_MD5                                  = local.config_source_md5
    AZURE_TENANT_ID                             = var.tenant_id
    AZURE_CLIENT_ID                             = var.client_id
    AZURE_CLIENT_SECRET                         = var.client_secret
  }

  config_source_md5 = var.config_content == null && var.config_source == null ? md5(local.default_config) : (var.config_source == null ? md5(var.config_content) : filemd5(var.config_source))

  config_content = var.config_content == null && var.config_source == null ? local.default_config : var.config_content
}

resource "azurerm_network_security_group" "sg" {
  name                = "${var.name}-sg"
  location            = var.location
  security_rule       = []
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "sga" {
  network_security_group_id = azurerm_network_security_group.sg.id
  subnet_id                 = azurerm_subnet.sn.id
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.name}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "sn" {
  name                                           = "${var.name}-vn"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vn.name
  address_prefixes                               = ["10.0.2.0/24"]
  service_endpoints                              = ["Microsoft.ContainerRegistry"]
  enforce_private_link_endpoint_network_policies = true

  delegation {
    name = "${var.name}-delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "random_string" "random" {
  length  = 5
  lower   = true
  upper   = false
  special = false
  number  = false
}

resource "azurerm_network_profile" "np" {
  name                = "${var.name}-script"
  location            = var.location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = "${var.name}-ni"

    ip_configuration {
      name      = "acrfrontal"
      subnet_id = azurerm_subnet.sn.id
    }
  }
}

resource "azurerm_container_group" "cg" {
  name                = "${var.name}-group"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.np.id

  container {
    name   = "${var.name}-container"
    image  = var.image
    cpu    = var.cpu
    memory = var.memory

    environment_variables = local.env_vars

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  tags = var.tags
}
