# Sysdig Secure for Cloud in Azure<br/>[ Example: tenant-Subscriptions on Kubernetes Cluster ]

Deploy Sysdig Secure for Cloud in a provided existing Kubernetes Cluster.

- Sysdig **Helm** [cloud-connector chart](https://charts.sysdig.com/charts/cloud-connector/) will be used to deploy
  threat-detection and scanning features
- Used architecture is similar
  to [tenant-subscriptions](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/tenant-subscriptions)
  but changing Container Group Instance <---> with an existing K8s

- All the required resources and workloads will be run under the same Azure subscription.

## Prerequisites

Minimum requirements:

1. Configure [Terraform **Azure** Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
2. Configure [**Helm** Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs) for **Kubernetes**
   cluster
3. **Sysdig Secure** requirements, as module input variable value
    ```
    sysdig_secure_api_token=<SECURE_API_TOKEN>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "<SUBSCRIPTION_ID>"
}

provider "sysdig" {
  sysdig_secure_url       =  "<SYSDIG_SECURE_URL>"
  sysdig_secure_api_token =  "<SYSDIG_SECURE_API_TOKEN>"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "secure-for-cloud_example_single-subscription-k8s" {
  source                  = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription-k8s"
}
```

See [inputs summary](#inputs) or module module [`variables.tf`](./variables.tf) file for more optional configuration.

### Notice
* This example will create resources that **cost money**. Run `terraform destroy` when you don't need them anymore.
* All created resources will be created within the tags `product:sysdig-secure-for-cloud`.
* For **free subscription** users, beware that this example may not deploy properly due to the [1 cloud-account limitation](https://docs.sysdig.com/en/docs/administration/administration-settings/subscription/#cloud-billing-free-tier). Open an Issue so we can help you here!


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.3.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.27 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.48.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |
| <a name="provider_sysdig"></a> [sysdig](#provider\_sysdig) | 0.7.4 |

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
| [azurerm_subscriptions.available](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |
| [sysdig_secure_connection.current](https://registry.terraform.io/providers/sysdiglabs/sysdig/latest/docs/data-sources/secure_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_benchmark_subscription_ids"></a> [benchmark\_subscription\_ids](#input\_benchmark\_subscription\_ids) | Azure subscription IDs to run Benchmarks on. If no subscriptions are specified, all of the tenant will be used. | `list(string)` | `[]` | no |
| <a name="input_cloud_connector_image"></a> [cloud\_connector\_image](#input\_cloud\_connector\_image) | Cloud-connector image to deploy | `string` | `"quay.io/sysdig/cloud-connector"` | no |
| <a name="input_deploy_active_directory"></a> [deploy\_active\_directory](#input\_deploy\_active\_directory) | whether the Active Directory features are to be deployed | `bool` | `true` | no |
| <a name="input_deploy_benchmark"></a> [deploy\_benchmark](#input\_deploy\_benchmark) | whether benchmark module is to be deployed | `bool` | `true` | no |
| <a name="input_deploy_scanning"></a> [deploy\_scanning](#input\_deploy\_scanning) | whether scanning module is to be deployed | `bool` | `false` | no |
| <a name="input_existing_registries"></a> [existing\_registries](#input\_existing\_registries) | existing  Azure Container Registry names to be included to  scan by resource group { resource\_group\_1 =  ["registry\_name\_11","registry\_name\_12"],resource\_group\_2 =  ["registry\_name\_21","registry\_name\_22"]}. By default it will create a new ACR | `map(list(string))` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"westus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to deploy Secure for Cloud stack | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to the resources | `map(string)` | <pre>{<br>  "product": "sysdig-secure-for-cloud"<br>}</pre> | no |
| <a name="input_threat_detection_subscription_ids"></a> [threat\_detection\_subscription\_ids](#input\_threat\_detection\_subscription\_ids) | Azure subscription IDs to run threat detection on. If no subscriptions are specified, all of the tenant will be used. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
