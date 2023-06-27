locals {
  config_without_scanning = yamlencode({
    logging = var.logging
    rules   = []
    ingestors = [
      {
        azure-event-hub : {
          subscriptionID : var.subscription_id
        }
      },
    ],
  })

  config_with_scanning = yamlencode({
    logging = var.logging
    rules   = []
    ingestors = concat(
      [
        {
          azure-event-hub : {
            subscriptionID : var.subscription_id
          }
        },
      ],
      [
        {
          azure-event-grid : {
            subscriptionID : var.subscription_id
          }
        },
      ]
    )
    scanners : [
      { azure-acr : {} },
      { azure-aci : {
        subscriptionID : var.subscription_id
        resourceGroup : var.resource_group_name
        containerRegistry : var.container_registry
        }
      }
    ]
  })

  default_config = var.deploy_scanning ? local.config_with_scanning : local.config_without_scanning
}
