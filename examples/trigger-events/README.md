# Sysdig Secure for Cloud in Azure<br/>[ Example :: Trigger-Events]

This example helps to trigger Azure Events. Cloud connector stack is required to be able to generate events.
After applying the module, this will create a new Security Group named _triggerazureevent_ in an **exisiting** resource group.
**Azure Access Level creation attempt for Blob Container Set to Public** event will prompt once the module is destroyed.

## Prerequisites

Minimum requirements:

1. Deploy Cloud Connector Stack on Azure
2. Configure [Terraform **Azure** Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
3. **Sysdig Secure** requirements, as module input variable value
    ```
    resource_group_name = <EXISTING_RESOURCE_GROUP_NAME>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
provider "azurerm" {
  features {}
  subscription_id = "<SUBSCRIPTION_ID>"
}

module "secure_for_cloud_trigger_events" {
  source                  = "sysdiglabs/secure-for-cloud/azurerm//examples/trigger-events"
  resource_group_name     = "existing-resource-group"
}
```

See [inputs summary](#inputs) or module
module [`variables.tf`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/new_resource_group/variables.tf)
file for more optional configuration.

To run this example you need be logged in Azure using Azure CLI tool and to execute:

```terraform
$ terraform init
$ terraform plan
$ terraform apply
```

Notice that:

* This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore
* All created resources will be created within the tags `product:sysdig-secure-for-cloud`, within the
  resource-group `sysdig-secure-for-cloud`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.64.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.96.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
