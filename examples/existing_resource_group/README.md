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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.64.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudvision"></a> [cloudvision](#module\_cloudvision) | sysdiglabs/cloudvision/azurerm |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
