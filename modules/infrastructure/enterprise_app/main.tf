locals {
  scopes = toset([for s in var.subscription_ids : "/subscriptions/${s}"])
}

resource "azuread_application" "aa" {
  display_name = "${var.name}-sd-app"
}

resource "azuread_service_principal" "asp" {
  application_id = azuread_application.aa.application_id
}

resource "azuread_service_principal_password" "aspp" {
  service_principal_id = azuread_service_principal.asp.id
  depends_on = [
    azuread_application.aa
  ]
}

resource "azuread_application_password" "aap" {
  application_object_id = azuread_application.aa.object_id
  depends_on = [
    azuread_application.aa
  ]
}

resource "azurerm_role_definition" "ard" {
  name  = "${var.name}-sd-role"
  scope = "/subscriptions/${var.subscription_ids[0]}"

  permissions {
    actions = [
      "Microsoft.ContainerRegistry/registries/listCredentials/action",
      "Microsoft.ContainerRegistry/registries/scheduleRun/action",
      "Microsoft.ContainerRegistry/registries/buildTasks/write",
      "Microsoft.ContainerInstance/containerGroups/read"
    ]
    not_actions = []
  }

  assignable_scopes = local.scopes
}

resource "azurerm_role_assignment" "main" {
  for_each           = local.scopes
  scope              = each.value
  role_definition_id = azurerm_role_definition.ard.role_definition_resource_id
  principal_id       = azuread_service_principal.asp.id
}
