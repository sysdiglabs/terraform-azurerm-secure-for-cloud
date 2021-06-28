<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.65.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_infrastructure"></a> [base\_infrastructure](#module\_base\_infrastructure) | ../base-infrastructure | n/a |

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_content"></a> [config\_content](#input\_config\_content) | Configuration contents for the file stored in the bucket | `string` | `null` | no |
| <a name="input_config_source"></a> [config\_source](#input\_config\_source) | Path to a file that contains the contents of the configuration file to be saved in the bucket | `string` | `"cloud-connector.yml"` | no |
| <a name="input_image"></a> [image](#input\_image) | Image of the cloud-connector to deploy | `string` | `"sysdiglabs/cloud-connector:latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"centralus"` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for cloud connector resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly | `string` | `"cloudconnector"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID where apply the infrastructure | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig's Secure API URL | `string` | `"https://secure-staging.sysdig.com/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "Team": "Sysdig"<br>}</pre> | no |
| <a name="input_verify_ssl"></a> [verify\_ssl](#input\_verify\_ssl) | Verify the SSL certificate of the Secure endpoint | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob_url"></a> [blob\_url](#output\_blob\_url) | url |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
