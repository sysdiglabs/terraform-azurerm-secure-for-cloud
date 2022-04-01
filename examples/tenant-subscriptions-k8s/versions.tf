terraform {
  required_version = ">= 0.15.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.3.0"
    }
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = ">= 0.5.27"
    }
  }
}
