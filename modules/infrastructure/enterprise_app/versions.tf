terraform {
  required_version = ">= 0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.71"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.41"
    }
  }
}
