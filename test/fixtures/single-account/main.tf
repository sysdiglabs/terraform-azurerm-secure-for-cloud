module "cloudvision_example_existing_resource_group" {
  source = "../../../examples/single-account"

  subscription_id         = var.subscription_id
  sysdig_secure_api_token = var.sysdig_secure_api_token
  name                    = "kitchen-test"
}
