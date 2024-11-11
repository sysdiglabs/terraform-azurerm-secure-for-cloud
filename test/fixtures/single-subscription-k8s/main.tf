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

  name                    = "kitchenk8s"
  deploy_scanning         = true
  deploy_active_directory = false
}
