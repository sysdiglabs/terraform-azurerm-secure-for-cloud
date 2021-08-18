# Sysdig Secure for Cloud in Azure:  Existing resource group

This module example uses a existing resource group to  deploy all module resources.

## Usage

For quick testing, use this snippet on your terraform files

```terraform
provider "azurerm" {
  features {}
  subscription_id = "00000000-1111-2222-3333-444444444444"
}

module "cloudvision_new_resource_group" {
  source = "sysdiglabs/cloudvision/azure//examples/existing_resource_group"

  sysdig_secure_api_token        = "11111111-0000-3333-4444-555555222224"
  resource_group_name            = "your_resource_group_name"
}
```