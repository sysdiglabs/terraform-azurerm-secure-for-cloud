
# Event hub

Deploys an Event Hub and a diagnostic setting.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.7.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.85.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.85.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.aev](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.eh_auth_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.evn](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.ns_auth_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_monitor_aad_diagnostic_setting.active_directory_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/2.85.0/docs/resources/monitor_diagnostic_setting) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | n/a | yes |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | Subscription IDs where apply the infrastructure | `list(string)` | n/a | yes |
| <a name="input_active_directory_logs"></a> [active\_directory\_logs](#input\_active\_directory\_logs) | List of active director log categories. | `list(string)` | <pre>[<br>  "SignInLogs",<br>  "AuditLogs",<br>  "NonInteractiveUserSignInLogs",<br>  "ServicePrincipalSignInLogs",<br>  "ManagedIdentitySignInLogs",<br>  "ProvisioningLogs",<br>  "ADFSSignInLogs"<br>]</pre> | no |
| <a name="input_deploy_ad_diagnostic_setting"></a> [deploy\_ad\_diagnostic\_setting](#input\_deploy\_ad\_diagnostic\_setting) | whether the diagnostic setting is to be deployed | `bool` | `true` | no |
| <a name="input_deploy_diagnostic_setting"></a> [deploy\_diagnostic\_setting](#input\_deploy\_diagnostic\_setting) | whether the diagnostic settings are to be deployed | `bool` | `true` | no |
| <a name="input_eventhub_partition_count"></a> [eventhub\_partition\_count](#input\_eventhub\_partition\_count) | The partition count setting allows you to parallelize consumption across many consumers | `number` | `1` | no |
| <a name="input_eventhub_retention_days"></a> [eventhub\_retention\_days](#input\_eventhub\_retention\_days) | The message retention setting specifies how long the Event Hubs service keeps data | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"centralus"` | no |
| <a name="input_logs"></a> [logs](#input\_logs) | List of log categories. | `list(string)` | <pre>[<br>  "Administrative",<br>  "Security",<br>  "ServiceHealth",<br>  "Alert",<br>  "Recommendation",<br>  "Policy",<br>  "Autoscale",<br>  "ResourceHealth"<br>]</pre> | no |
| <a name="input_namespace_capacity"></a> [namespace\_capacity](#input\_namespace\_capacity) | Processing units or throughput units are pre-purchased units of capacity | `number` | `1` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Pricing tier plan [Basic, Standard, Premium] | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "Team": "Sysdig"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_eventhub_connection_string"></a> [azure\_eventhub\_connection\_string](#output\_azure\_eventhub\_connection\_string) | EventHub SAS policy connection string |
| <a name="output_azure_eventhub_id"></a> [azure\_eventhub\_id](#output\_azure\_eventhub\_id) | EventHub ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
