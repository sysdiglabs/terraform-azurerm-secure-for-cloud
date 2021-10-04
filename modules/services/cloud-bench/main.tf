locals {
  subscription_ids = var.is_tenant ? var.subscription_ids : [var.subscription_id]
}

module "trust_relationship" {
  for_each = toset(local.subscription_ids)
  source   = "./trust_relationship"

  subscription_id             = each.key
  region                      = var.region
  sysdig_tenant_id            = var.sysdig_tenant_id
  sysdig_service_principal_id = var.sysdig_service_principal_id
}

module "task" {
  source           = "./task"
  subscription_id  = var.subscription_id
  subscription_ids = var.subscription_ids
  is_tenant        = var.is_tenant
  region           = var.region

  depends_on = [module.trust_relationship]
}