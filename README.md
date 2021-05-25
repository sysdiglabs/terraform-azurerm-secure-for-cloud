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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.dummy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/lb) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_removeme"></a> [removeme](#output\_removeme) | Added only to create initial pipeline |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Sysdig](https://github.com/sysdiglabs/terraform-azurerm-cloudvision).

## License

Apache 2 Licensed. See LICENSE for full details.
