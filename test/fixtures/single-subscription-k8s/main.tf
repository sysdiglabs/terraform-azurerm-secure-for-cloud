terraform {
  required_version = ">= 0.15.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.2"
    }
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = ">= 0.5.27"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "sysdig" {
  sysdig_secure_url       = var.sysdig_secure_endpoint
  sysdig_secure_api_token = var.sysdig_secure_api_token
}

module "s4c_single_account_k8s_example" {
  source = "../../../examples/single-subscription-k8s"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchenk8s"
  deploy_scanning         = true
  deploy_benchmark        = false
  deploy_active_directory = false
}
