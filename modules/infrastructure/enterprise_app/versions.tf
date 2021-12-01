terraform {
  required_version = ">= 0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.87.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.7.0"
    }
  }
}
