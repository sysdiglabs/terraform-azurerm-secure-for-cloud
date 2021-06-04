# Cloud Vision deploy in Azure Module

This repository contains a Module for how to deploy the Cloud Vision in Azure with different components
deployment that will detect events in your infrastructure.

## Usage

```hcl
module "cloud_vision_azure" {
  source = "sysdiglabs/cloudvision/azurerm"

  /* TBD */
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.aev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_namespace.evn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.ns_auth_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_monitor_diagnostic_setting.diag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logs"></a> [logs](#input\_logs) | List of log categories to log. | `list(string)` | <pre>[<br>  "Administrative",<br>  "Security",<br>  "ServiceHealth",<br>  "Alert",<br>  "Recommendation",<br>  "Policy",<br>  "Autoscale",<br>  "ResourceHealth"<br>]</pre> | no |
| <a name="input_targets_map"></a> [targets\_map](#input\_targets\_map) | Azure subscription | `map(string)` | <pre>{<br>  "/subscriptions/c3ea21a5-e474-4ed3-bf6c-b35fe3f9bea1": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_removeme"></a> [removeme](#output\_removeme) | Added only to create initial pipeline |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Sysdig](https://github.com/sysdiglabs/terraform-azurerm-cloudvision).

## License

Apache 2 Licensed. See LICENSE for full details.
