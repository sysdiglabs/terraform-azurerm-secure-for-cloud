# Sysdig Secure for Cloud in Azure:  Existing resource group

This module example uses a existing resource group to deploy all module resources.

## Prerequisites

Minimum requirements:

1. Azure CLI login
2. Azure subscription ID, as provider input variable
    ```
    subscription_id=<SUBSCRIPTION_ID>
    ```
3. Existing resource group name, as module input variable value
    ```
    resource_group_name=<RESOURCE_GROUP_NAME>
    ```
4. Secure requirements, as module input variable value
    ```
    sysdig_secure_api_token=<SECURE_API_TOKEN>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
provider "azurerm" {
  features {}
  subscription_id = "00000000-1111-2222-3333-444444444444"
}

module "cloudvision_example_new_resource_group" {
  source = "sysdiglabs/cloudvision/azurerm//examples/existing_resource_group"

  sysdig_secure_api_token        = "11111111-0000-3333-4444-555555222224"
  resource_group_name            = "your_resource_group_name"
}
```

See [inputs summary](#inputs) or module module [`variables.tf`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/existing_resource_group/variables.tf) file for more optional configuration.

To run this example you need be logged in Azure using Azure CLI tool and to execute:
```terraform
$ terraform init
$ terraform plan
$ terraform apply
```

Notice that:
* This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore
* All created resources will be created within the tags `product:sysdig-secure-for-cloud`, within the resource-group `sysdig-secure-for-cloud`
