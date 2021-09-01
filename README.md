# Sysdig Secure for Cloud in Azure

Terraform module that deploys the **Sysdig Secure for Cloud** stack in **Azure**. It provides unified threat detection, compliance, forensics and analysis.

There are three major component:

* Cloud Threat Detection: Tracks abnormal and suspicious activities in your cloud environment based on Falco language.Managed through [cloud-connector module](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/modules/services/cloud-connector).
* CSPM/Compliance: It evaluates periodically your cloud configuration, using Cloud Custodian, against some benchmarks and returns the results and remediations you need to fix.
* Cloud Scanning: Automatically scans all container images pushed to the registry or as soon a new task which involves a container is spawned in your account.

For other Cloud providers check: [AWS](https://github.com/sysdiglabs/terraform-aws-secure-for-cloud), [GCP](https://github.com/sysdiglabs/terraform-google-secure-for-cloud)

## Usage

There are two ways to deploy this in you Azure infrastructure:

* Using an existing resource group name (more info in the [`./examples/existing_resource_group/README.md`](examples/existing_resource_group/README.md))
* Creating a new resource group name (more info in the [`./examples/creating_resource_group/README.md`](examples/creating_resource_group/README.md))


Notice that:
- These examples will create resources that cost money. Run `terraform destroy` when you don't need them anymore
- All created resources will be created within the tags `product:sysdig-secure-for-cloud`

---

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_connector"></a> [cloud\_connector](#module\_cloud\_connector) | ./modules/services/cloud-connector |  |
| <a name="module_infrastructure_eventhub"></a> [infrastructure\_eventhub](#module\_infrastructure\_eventhub) | ./modules/infrastructure/eventhub |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.64.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudconnector_deploy"></a> [cloudconnector\_deploy](#input\_cloudconnector\_deploy) | Whether to deploy or not CloudConnector | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"centralus"` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly | `string` | `"cloudvision"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy cloud vision stack | `string` | `""` | no |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig Secure API endpoint | `string` | `"https://secure.sysdig.com"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "product": "sysdig-secure-for-cloud"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
