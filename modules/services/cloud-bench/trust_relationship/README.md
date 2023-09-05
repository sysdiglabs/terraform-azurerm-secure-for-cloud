<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.71.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.27 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |
| <a name="provider_sysdig"></a> [sysdig](#provider\_sysdig) | 1.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lighthouse_assignment.lighthouse_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lighthouse_assignment) | resource |
| [azurerm_lighthouse_definition.lighthouse_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lighthouse_definition) | resource |
| [sysdig_secure_cloud_account.cloud_account](https://registry.terraform.io/providers/sysdiglabs/sysdig/latest/docs/resources/secure_cloud_account) | resource |
| [azurerm_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [sysdig_secure_trusted_cloud_identity.trusted_identity](https://registry.terraform.io/providers/sysdiglabs/sysdig/latest/docs/data-sources/secure_trusted_cloud_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID in which to create a Trust Relationship | `string` | n/a | yes |
| <a name="input_use_reader_role"></a> [use\_reader\_role](#input\_use\_reader\_role) | Set this flag to `true` to use the `Reader` role instead of the `Contributor` role. Some CSPM controls will not function correctly if this option is enabled | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
