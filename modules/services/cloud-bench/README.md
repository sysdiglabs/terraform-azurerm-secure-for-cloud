<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.85.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.27 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_task"></a> [task](#module\_task) | ./task | n/a |
| <a name="module_trust_relationship"></a> [trust\_relationship](#module\_trust\_relationship) | ./trust_relationship | n/a |

## Resources

No resources.

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
