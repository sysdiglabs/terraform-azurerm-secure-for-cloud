# Sysdig Secure for Cloud in Azure

Terraform module that deploys the [**Sysdig Secure for Cloud** stack in **Azure**](https://docs.sysdig.com/en/docs/installation/sysdig-secure-for-cloud/deploy-sysdig-secure-for-cloud-on-azure)
.
<br/>

Provides unified threat-detection, compliance, forensics and analysis through these major components:

* **[Threat Detection](https://docs.sysdig.com/en/docs/sysdig-secure/insights/)**: Tracks abnormal and suspicious
  activities in your cloud environment based on Falco language. Managed through `cloud-connector` module. <br/>

* **[Compliance](https://docs.sysdig.com/en/docs/sysdig-secure/posture/compliance/compliance-unified-/)**: Enables the
  evaluation of standard compliance frameworks. Requires both modules  `cloud-connector` and `cloud-bench`. <br/>

* **[Image Scanning](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/)**:
  Automatically scans images that run on the Azure workload (currently AzureContainerInstances).<br/>
  Define an AzureRegistry (ACR) through `registry_name` and also scan all the repository images pushed to the
  registry.<br/>
  Managed through `cloud-connector`. <br/>Scanning is disabled by default, can be enabled through `deploy_scanning`
  input variable parameters.<br/>

For other Cloud providers check: [AWS](https://github.com/sysdiglabs/terraform-aws-secure-for-cloud)
, [GCP](https://github.com/sysdiglabs/terraform-google-secure-for-cloud)

## Permissions

- Threat Detection feature requires `Contributor` subscritpion-level role user assignment
    - For AD diagnostic `Security Administrator` role must be granted to at Organizational level.

      Otherwise, it can be disabled setting `deploy_active_directory=false` on all examples
- For scanning, an App (with its Service Principal) is required to be created in the ActiveDirectory, to enable
  ContainerRegistry Task to run the image scanning This requires subscription-level `Security Administrator` role.

Note: Beware that pervious roles in AD are found in two different levels; Organizational level (user AD **Assigned
Roles**), and Subscription level (user AD **Azure role assignments**). This role assignments take some time to
consolidate.

![Azure AD roles](./resources/troubleshoot-ad-roles.png)


## Notice
* **Resource creation inventory** Find all the resources created by Sysdig examples in the resource-group `sysdig-secure-for-cloud`<br/>
* All Sysdig Secure for Cloud features but [Image Scanning](https://docs.sysdig.com/en/docs/sysdig-secure/scanning/) are enabled by default. You can enable it through `deploy_scanning` input variable parameters.<br/>
* **Deployment cost** This example will create resources that cost money. Run `terraform destroy` when you don't need them anymore
* For **free subscription** users, beware that organizational examples may not deploy properly due to the [1 cloud-account limitation](https://docs.sysdig.com/en/docs/administration/administration-settings/subscription/#cloud-billing-free-tier). Open an Issue so we can help you here!
<br/>

## Usage

### - Single-Subscription

Sysdig workload will be deployed in the same account where user's resources will be watched.<br/>
More info
in [`./examples/single-subscription`](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples/single-subscription)

![single project diagram](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/single-subscription/diagram-single.png?raw=true)

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

![tenant subscription diagram](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/tenant-subscriptions/diagram-tenant.png?raw=true)

### - Self-Baked

If no [examples](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/tree/master/examples) fit your
use-case, be free to call desired modules directly.

In this use-case we will ONLY deploy cloud-bench, into the target account, calling modules directly

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
  subscription_id = "SUBSCRIPTION-ID"
}

data "azurerm_subscription" "current" {
}

provider "sysdig" {
  sysdig_secure_url       = var.sysdig_secure_endpoint
  sysdig_secure_api_token = var.sysdig_secure_api_token
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

## Forcing Events

**Threat Detection**

Terraform example module to trigger _Azure Access Level creation attempt for Blob Container Set to Public_ event can be
found
on [examples/trigger-events](https://github.com/sysdiglabs/terraform-azurerm-secure-for-cloud/blob/master/examples/trigger-events)
.

This can also be tested manually; choose one of the rules contained in the Sysdig `Azure Best Practices` policy and
execute it in your Azure account.

**Image Scanning**

- For registry image scanning (ACR), upload any image to a registry repository.
  ```shell
  $ docker login -u xxx -p  xxx your-registry.azurecr.io  # acr access-key user and password
  $ docker tag your-registry.azurecr.io/artifact:tag
  $ docker push your-registry.azurecr.io/artifact:tag
  ```
- For workload image scanning in AzureContainerInstances (ACI), deploy any workload to an instance. Azure gives you the option for a quickstart
  ![azure aci quickstart](./resources/aci-quickstart.png)

## Troubleshooting

### Q-Scanning: I see no image result on Secure

A: 1. Check that the repository where you're uploading images to, is from a registry that has been configured on the
deployment, otherwise configure it through `registry_name` input variable <br/>

2. Check that in this registry 'Tasks > Runs' a new image scanning deployment has been spawned<br/>
3. Check if in the CloudConnector ContainerInstance any log shows that a new image has been detected<br/>

### Q-Azure: Getting Error 403 on Monitor AAD Diagnostic Setting

```shell
??? Error: checking for presence of existing Monitor AAD Diagnostic Setting: (Name "iru-aad-diagnostic-setting"):
aad.DiagnosticSettingsClient#Get: Failure responding to request: StatusCode=403
-- Original Error: autorest/azure: Service returned an error.
Status=403 Code="AuthorizationFailed" Message="The client 'iru@***.onmicrosoft.com' with object id '***' does not have authorization to perform action
'microsoft.aadiam/diagnosticSettings/read' over scope '/providers/microsoft.aadiam/diagnosticSettings/iru-aad-diagnostic-setting' or the scope is invalid.
If access was recently granted, please refresh your credentials."
```

A: Deployment user has not enough permissions to enable AD diagnostic settings for threat-detection.<br/>
S:  Check [Permissions](#permissions) section

### Q-Azure: Getting Error 404 could not configure MSI Authorizer: NewMsiConfig: could not validate MSI endpoint

```shell
???
??? Error: could not configure MSI Authorizer: NewMsiConfig: could not validate MSI endpoint: received HTTP status 404
???
???   with provider["registry.terraform.io/hashicorp/azuread"],
???   on main.tf line 1, in provider "azuread":
???    1: provider "azuread" {
```

A: This may happen if you're using Azure console shell to deploy terraform. MSI (managed service identity has connection
limitations)<br/>
S: Unset `MSI_ENDPOINT` environment variable [[1](https://github.com/hashicorp/terraform-provider-azuread/issues/633)].
We will upgrade provider soon to avoid this.

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
