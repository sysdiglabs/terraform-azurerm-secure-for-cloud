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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.64.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_connector"></a> [cloud\_connector](#module\_cloud\_connector) | ./modules/cloud-connector | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudconnector_config_file"></a> [cloudconnector\_config\_file](#input\_cloudconnector\_config\_file) | Cloud connector config file absolute path | `string` | `"modules/cloud-connector/cloud-connector.yml"` | no |
| <a name="input_cloudconnector_deploy"></a> [cloudconnector\_deploy](#input\_cloudconnector\_deploy) | Whether to deploy or not CloudConnector | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"centralus"` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID where apply the infrastructure | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig Secure API endpoint | `string` | `"https://secure.sysdig.com"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "Team": "Sysdig"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_removeme"></a> [removeme](#output\_removeme) | Added only to create initial pipeline |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Sysdig](https://github.com/sysdiglabs/terraform-azurerm-cloudvision).

## License

Apache 2 Licensed. See LICENSE for full details.
