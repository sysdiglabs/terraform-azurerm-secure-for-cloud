###################################################
# Fetch & compute required data
###################################################

//data "sysdig_secure_trusted_cloud_identity" "trusted_identity" {
//  cloud_provider = "azure"
//}

data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}

locals {
  regions_scope_clause = length(var.region) == 0 ? "" : " and azure.region = \"${var.region}\""
}

###################################################
# Configure Sysdig Backend
###################################################

resource "sysdig_secure_cloud_account" "cloud_account" {
  account_id     = data.azurerm_subscription.subscription.subscription_id
  alias          = data.azurerm_subscription.subscription.id
  cloud_provider = "azure"
  role_enabled   = "true"
}

resource "sysdig_secure_benchmark_task" "benchmark_task" {
  name     = "Sysdig Secure for Cloud (Azure) - ${data.azurerm_subscription.subscription.id}"
  schedule = "0 6 * * *"
  schema   = "azure_foundations_bench-1.3.0"
  scope    = "azure.subscriptionId = \"${data.azurerm_subscription.subscription.subscription_id}\"${local.regions_scope_clause}"

  # Creation of a task requires that the Cloud Account already exists in the backend, and has `role_enabled = true`
  depends_on = [sysdig_secure_cloud_account.cloud_account]
}



data "azurerm_role_definition" "reader" {
  role_definition_id = "acdd72a7-3385-48ef-bd42-f606fba81ae7"
}

resource "azurerm_lighthouse_definition" "lighthouse_definition" {
  name               = "Sysdig CloudBench Lighthouse Definition"
  description        = "Lighthouse definition representing Sysdig CloudBench offer"
  managing_tenant_id = var.sysdig_tenant_id
  scope              = "/subscriptions/${var.subscription_id}"

  authorization {
    principal_id           = var.sysdig_service_principal_id
    role_definition_id     = data.azurerm_role_definition.reader.role_definition_id
    principal_display_name = "Sysdig CloudBench Service Principal"
  }
}

resource "azurerm_lighthouse_assignment" "lighthouse_assignment" {
  scope                     = "/subscriptions/${var.subscription_id}"
  lighthouse_definition_id  = azurerm_lighthouse_definition.lighthouse_definition.id
}