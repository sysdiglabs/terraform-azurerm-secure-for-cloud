terraform {
  required_version = ">= 0.15.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.87.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.3.0"
    }
  }
}
