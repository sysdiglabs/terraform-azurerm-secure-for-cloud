terraform {
  required_version = ">= 0.15.0"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.71"
    }
  }
}
