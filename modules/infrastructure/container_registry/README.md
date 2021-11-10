
# Container registry

Deploys a container registry and creates an Event Grid to send Image Push and Chart Push events to EventHub.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.64.0/docs/resources/container_registry) | resource |
| [azurerm_eventgrid_event_subscription.default](https://registry.terraform.io/providers/hashicorp/azurerm/2.64.0/docs/resources/eventgrid_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_endpoint_id"></a> [eventhub\_endpoint\_id](#input\_eventhub\_endpoint\_id) | Specifies the id where the Event Hub is located | `string` | n/a | yes |
| <a name="input_georeplication"></a> [georeplication](#input\_georeplication) | A list of Azure locations where the container registry should be geo-replicated | `list(string)` | <pre>[<br>  "centralus"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Pricing tier plan [Basic, Standard, Premium] | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry"></a> [container\_registry](#output\_container\_registry) | Created container registry name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.