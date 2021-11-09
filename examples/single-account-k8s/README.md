# Sysdig Secure for Cloud in Azure<br/>[ Example: Single-Subscription on Kubernetes Cluster ]

Deploy Sysdig Secure for Cloud in a provided existing Kubernetes Cluster.

- Sysdig **Helm** charts will be used to deploy the secure-for-cloud stack:
    - [Cloud-Connector Chart](https://charts.sysdig.com/charts/cloud-connector/)
- Used architecture is similar to [single-project](../single-project) but changing Container Group Instance <---> with
  an existing K8s

All the required resources and workloads will be run under the same GCP project.

## Prerequisites

Minimum requirements:


1. **Azure** profile credentials configuration
2. **Kubernetes** cluster configured within your helm provider
3. **Sysdig** Secure requirements, as input variable value
    ```
    sysdig_secure_api_token=<SECURE_API_TOKEN>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
module "secure_for_cloud_azurerm_single_project_k8s" {
  source = "sysdiglabs/secure-for-cloud/google//examples/single-project-k8s"

  subscription_id         = "00000000-1111-2222-3333-444444444444"
  sysdig_secure_api_token = "11111111-0000-3333-4444-555555222224"
}
```

See [inputs summary](#inputs) or module module [`variables.tf`](./variables.tf) file for more optional configuration.

Notice that:

* This example will create resources that **cost money**. Run `terraform destroy` when you don't need them anymore.
* All created resources will be created within the tags `product:sysdig-secure-for-cloud`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.64.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.64.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infrastructure_eventhub"></a> [infrastructure\_eventhub](#module\_infrastructure\_eventhub) | ../../modules/infrastructure/eventhub |  |

## Resources

| Name | Type |
|------|------|
| [helm_release.cloud_connector](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.64.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure subscription ID to use to deploy the resources | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_cloud_connector_image"></a> [cloud\_connector\_image](#input\_cloud\_connector\_image) | Cloud-connector image to deploy | `string` | `"quay.io/sysdig/cloud-connector"` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"testhayk"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy Secure for Cloud stack | `string` | `""` | no |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig Secure API endpoint | `string` | `"https://secure.sysdig.com"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "product": "sysdig-secure-for-cloud"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
