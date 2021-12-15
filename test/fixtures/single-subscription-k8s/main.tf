provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "s4c_single_account_k8s_example" {
  source = "../../../examples/single-subscription-k8s"

  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchenk8s"
  deploy_benchmark        = false
}
