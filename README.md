# Sysdig Secure for Cloud in Azure

Terraform module that deploys the [**Sysdig Secure for Cloud** stack in **
Azure**](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-azure).
<br/>

Provides unified threat-detection, compliance, forensics and analysis through these major components:

* **[CSPM/Compliance](https://docs.sysdig.com/en/docs/sysdig-secure/benchmarks/)**: It evaluates periodically your cloud
  configuration, using Cloud Custodian, against some benchmarks and returns the results and remediation you need to fix.
  Managed through `cloud-bench` module. <br/>
  Note: This feature is under development, not available yet.

* **[Cloud Threat Detection](https://docs.sysdig.com/en/docs/sysdig-secure/insights/)**: Tracks abnormal and suspicious
  activities in your cloud environment based on Falco language. Managed through `cloud-connector` module. <br/>

* **[Cloud Scanning](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/)**: Automatically scans all container
  images pushed to the registry or as soon a new task which involves a container is spawned in your account. Managed
  through `cloud-connector`. <br/>

For other Cloud providers check: [AWS](https://github.com/sysdiglabs/terraform-aws-secure-for-cloud)
, [GCP](https://github.com/sysdiglabs/terraform-google-secure-for-cloud)

## Permissions

- Threat Detection requires `Contributor` role user authentication
- For scanning, an App (with its Service Principal) is required to be created in the ActiveDirectory, to enable
  ContainerRegistry Task to run the image scanning This requires `Security Administrator` role.

## Usage

### - Single-Subscription

Sysdig workload will be deployed in the same account where user's resources will be watched.<br/>
More info
in [`./examples/single-subscription`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples/single-subscription)

![single project diagram](https://github.com/sysdiglabs/terraform-azure-secure-for-cloud/blob/master/examples/single-subscription/diagram-single.png?raw=true)

### - Single-Subscription with a pre-existing Kubernetes Cluster

If you already own a Kubernetes Cluster on GCP, you can use it to deploy Sysdig Secure for Cloud, instead of default
Container Group Instances.<br/>
More info
in [`./examples/single-subscription-k8s`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples/single-subscription-k8s)

### - Tenant-Subscriptions

Sysdig resources will only be deployed on the Sysdig-designated subscription, but features will be available on all the
Tenant subscriptions (by default), or the ones you select through the input variables.<br/>
More info
in [`./examples/tenant-subscriptions`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples/tenant-subscriptions)

![tenant subscription diagram](https://github.com/sysdiglabs/terraform-azure-secure-for-cloud/blob/master/examples/tenant-subscription/diagram-single.png?raw=true)

### - Self-Baked

If no [examples](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples) fit your
use-case, be free to call desired modules directly.

In this use-case we will ONLY deploy cloud-bench, into the target account, calling modules directly

```terraform
provider "azurerm" {
  features {}
  subscription_id = "SUBSCRIPTION-ID"
}

data "azurerm_subscription" "current" {
}

module "cloud_connector" {
  source = "sysdiglabs/secure-for-cloud/azurerm//modules/cloud-connector"

  subscription_id                  = data.azurerm_subscription.current.subscription_id
  resource_group_name              = "RESOURCE_GROUP_NAME"
  azure_eventhub_connection_string = "EXISTING_EVENTHUB_CONNECTION_STRING"
  sysdig_secure_api_token          = var.sysdig_secure_api_token
}

```

See [inputs summary](#inputs) or
main [module `variables.tf`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/variables.tf)
file for more optional configuration.

To run this example you need have an Azure account and to execute:

```terraform
$ terraform init
$ terraform plan
$ terraform apply
```

Notice that:

- These examples will create resources that cost money. Run `terraform destroy` when you don't need them anymore
- All created resources will be created within the tags `product:sysdig-secure-for-cloud`

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
