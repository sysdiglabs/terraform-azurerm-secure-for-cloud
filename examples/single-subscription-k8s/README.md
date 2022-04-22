# Sysdig Secure for Cloud in Azure<br/>[ Example: Single-Subscription on Kubernetes Cluster ]


Deploy Sysdig Secure for Cloud in a provided existing Kubernetes Cluster.

- Sysdig **Helm** [cloud-connector chart](https://charts.sysdig.com/charts/cloud-connector/) will be used to deploy threat-detection and scanning features
- Used architecture is similar to [single-subscription](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/single-subscription) but changing Container Group Instance <---> with
  an existing K8s

- All the required resources and workloads will be run under the same Azure subscription.

## Prerequisites

Minimum requirements:


1. Configure [Terraform **Azure** Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
2. Configure [**Helm** Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs) for **Kubernetes** cluster
3. **Sysdig Secure** requirements, as module input variable value
    ```
    sysdig_secure_api_token=<SECURE_API_TOKEN>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "secure-for-cloud_example_single-subscription-k8s" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription-k8s"
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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.3.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_bench"></a> [cloud\_bench](#module\_cloud\_bench) | ../../modules/services/cloud-bench | n/a |
| <a name="module_infrastructure_container_registry"></a> [infrastructure\_container\_registry](#module\_infrastructure\_container\_registry) | ../../modules/infrastructure/container_registry | n/a |
| <a name="module_infrastructure_enterprise_app"></a> [infrastructure\_enterprise\_app](#module\_infrastructure\_enterprise\_app) | ../../modules/infrastructure/enterprise_app | n/a |
| <a name="module_infrastructure_eventgrid_eventhub"></a> [infrastructure\_eventgrid\_eventhub](#module\_infrastructure\_eventgrid\_eventhub) | ../../modules/infrastructure/eventhub | n/a |
| <a name="module_infrastructure_eventhub"></a> [infrastructure\_eventhub](#module\_infrastructure\_eventhub) | ../../modules/infrastructure/eventhub | n/a |
| <a name="module_infrastructure_resource_group"></a> [infrastructure\_resource\_group](#module\_infrastructure\_resource\_group) | ../../modules/infrastructure/resource_group | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.cloud_connector](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_cloud_connector_image"></a> [cloud\_connector\_image](#input\_cloud\_connector\_image) | Cloud-connector image to deploy | `string` | `"quay.io/sysdig/cloud-connector"` | no |
| <a name="input_deploy_active_directory"></a> [deploy\_active\_directory](#input\_deploy\_active\_directory) | whether the Active Directory features are to be deployed | `bool` | `true` | no |
| <a name="input_deploy_benchmark"></a> [deploy\_benchmark](#input\_deploy\_benchmark) | whether benchmark module is to be deployed | `bool` | `false` | no |
| <a name="input_deploy_scanning"></a> [deploy\_scanning](#input\_deploy\_scanning) | whether scanning module is to be deployed | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to run benchmarks. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]. | `string` | `"AzureCloud"` | no |
| <a name="input_registry_name"></a> [registry\_name](#input\_registry\_name) | The existing Container Registry name | `string` | `""` | no |
| <a name="input_registry_resource_group_name"></a> [registry\_resource\_group\_name](#input\_registry\_resource\_group\_name) | The existing Container Registry name resource group name when is different than workload resource group name | `string` | `""` | no |
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
