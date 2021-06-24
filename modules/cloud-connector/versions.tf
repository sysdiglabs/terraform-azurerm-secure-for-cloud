terraform {
  required_version = ">= 0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}
