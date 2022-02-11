# Cloud Connector

A **Container instance** deployment that will detect events in your infrastructure.

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
| [azurerm_container_group.cg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_network_profile.np](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_profile) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_blob.sb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.sc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.sn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_eventgrid_eventhub_connection_string"></a> [azure\_eventgrid\_eventhub\_connection\_string](#input\_azure\_eventgrid\_eventhub\_connection\_string) | EventHub SAS policy connection string for event grid | `string` | n/a | yes |
| <a name="input_azure_eventhub_connection_string"></a> [azure\_eventhub\_connection\_string](#input\_azure\_eventhub\_connection\_string) | EventHub SAS policy connection string | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | Enterprise application ID | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | Enterprise application service principal secret | `string` | n/a | yes |
| <a name="input_container_registry"></a> [container\_registry](#input\_container\_registry) | Azure container registry name to run acr quick task for inline scanning | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID where deploy the cloud connector image | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure tenant ID | `string` | n/a | yes |
| <a name="input_config_content"></a> [config\_content](#input\_config\_content) | Configuration contents for the file stored in the bucket | `string` | `null` | no |
| <a name="input_config_source"></a> [config\_source](#input\_config\_source) | Path to a file that contains the contents of the configuration file to be saved in the bucket | `string` | `null` | no |
| <a name="input_deploy_scanning"></a> [deploy\_scanning](#input\_deploy\_scanning) | whether scanning module is to be deployed | `bool` | `false` | no |
| <a name="input_image"></a> [image](#input\_image) | Image of the cloud-connector to deploy | `string` | `"quay.io/sysdig/cloud-connector:latest"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc-connector"` | no |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig's Secure API URL | `string` | `"https://secure.sysdig.com/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "product": "sysdig-secure-for-cloud"<br>}</pre> | no |
| <a name="input_verify_ssl"></a> [verify\_ssl](#input\_verify\_ssl) | Verify the SSL certificate of the Secure endpoint | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob_url"></a> [blob\_url](#output\_blob\_url) | url |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
