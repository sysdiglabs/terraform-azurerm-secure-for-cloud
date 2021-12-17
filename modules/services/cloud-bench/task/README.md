<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.64.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.27 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.64.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |
| <a name="provider_sysdig"></a> [sysdig](#provider\_sysdig) | >= 0.5.27 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_integer.hour](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_integer.minute](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [sysdig_secure_benchmark_task.benchmark_task](https://registry.terraform.io/providers/sysdiglabs/sysdig/latest/docs/resources/secure_benchmark_task) | resource |
| [azurerm_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_subscriptions.available](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_tenant"></a> [is\_tenant](#input\_is\_tenant) | Whether this task is being created at the tenant or subscription level | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to run the benchmark. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]. | `string` | `"AzureCloud"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | ID of subscription containing resources to run benchmarks on | `string` | `""` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | IDs of subscriptions containing resources to run benchmarks on | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
