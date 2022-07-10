
# Container registry

Deploys a container registry and creates an Event Grid to send Image Push and Chart Push events to EventHub.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.11.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_eventgrid_event_subscription.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |
| [azurerm_eventgrid_event_subscription.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_container_registry.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_container_registry.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_endpoint_id"></a> [eventhub\_endpoint\_id](#input\_eventhub\_endpoint\_id) | Specifies the id where the Event Hub is located | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name where the stack has been deployed | `string` | n/a | yes |
| <a name="input_existing_registries"></a> [existing\_registries](#input\_existing\_registries) | Azure Container Registries to scan, by resource name | `map(list(string))` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | Pricing tier plan [Basic, Standard, Premium] | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry"></a> [container\_registry](#output\_container\_registry) | Azure Container Registry name |
| <a name="output_container_registry_resource_group"></a> [container\_registry\_resource\_group](#output\_container\_registry\_resource\_group) | Azure Container Registry resource group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
