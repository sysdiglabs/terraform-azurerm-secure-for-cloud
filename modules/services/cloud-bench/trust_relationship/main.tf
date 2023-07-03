###################################################
# Fetch & compute required data
###################################################

data "sysdig_secure_trusted_cloud_identity" "trusted_identity" {
  cloud_provider = "azure"
}

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

resource "azurerm_lighthouse_definition" "lighthouse_definition" {
  name               = "Sysdig Lighthouse Definition"
  description        = "Lighthouse definition for Sysdig Secure for Cloud"
  managing_tenant_id = data.sysdig_secure_trusted_cloud_identity.trusted_identity.azure_tenant_id
  scope              = "/subscriptions/${var.subscription_id}"

  authorization {
    principal_id           = data.sysdig_secure_trusted_cloud_identity.trusted_identity.azure_service_principal_id
    principal_display_name = "Sysdig Service Principal"

    # Uses Contributor (default) or Reader roles: https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
    role_definition_id = var.use_reader_role ? "acdd72a7-3385-48ef-bd42-f606fba81ae7" : "b24988ac-6180-42a0-ab88-20f7382dd24c"
  }
}

resource "azurerm_lighthouse_assignment" "lighthouse_assignment" {
  scope                    = "/subscriptions/${var.subscription_id}"
  lighthouse_definition_id = azurerm_lighthouse_definition.lighthouse_definition.id
}
