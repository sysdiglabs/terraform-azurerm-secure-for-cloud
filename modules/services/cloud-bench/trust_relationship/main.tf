###################################################
# Fetch & compute required data
###################################################

//data "sysdig_secure_trusted_cloud_identity" "trusted_identity" {
//  cloud_provider = "azure"
//}

data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}

###################################################
# Configure Sysdig Backend
###################################################

resource "sysdig_secure_cloud_account" "cloud_account" {
  account_id     = data.azurerm_subscription.subscription.subscription_id
  alias          = data.azurerm_subscription.subscription.display_name
  cloud_provider = "azure"
  role_enabled   = "true"
}

data "azurerm_role_definition" "reader" {
  role_definition_id = "acdd72a7-3385-48ef-bd42-f606fba81ae7"
}

resource "azurerm_lighthouse_definition" "lighthouse_definition" {
  name               = "Sysdig CloudBench Lighthouse Definition"
  description        = "Lighthouse definition representing Sysdig CloudBench offer"
  managing_tenant_id = data.sysdig_secure_trusted_cloud_identity.trusted_identity.azure_tenant_id
  scope              = "/subscriptions/${var.subscription_id}"

  authorization {
    principal_id           = data.sysdig_secure_trusted_cloud_identity.trusted_identity.azure_client_id
    role_definition_id     = data.azurerm_role_definition.reader.role_definition_id
    principal_display_name = "Sysdig CloudBench Service Principal"
  }
}

resource "azurerm_lighthouse_assignment" "lighthouse_assignment" {
  scope                    = "/subscriptions/${var.subscription_id}"
  lighthouse_definition_id = azurerm_lighthouse_definition.lighthouse_definition.id
}
