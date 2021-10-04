// For single project
variable "subscription_id" {
  type        = string
  description = "ID of subscription containing resources to run benchmarks on"
  default     = ""
}

// For tenant
variable "subscription_ids" {
  type        = list(string)
  description = "IDs of subscriptions containing resources to run benchmarks on"
  default     = []
}

#---------------------------------
# optionals - with default
#---------------------------------

variable "region" {
  type        = string
  description = "Region in which to run the benchmark. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}

variable "sysdig_tenant_id" {
  type        = string
  description = "Sysdig Tenant ID containing service principal that customer will grant resource access to"
  default     = "c7b56912-f4da-4f6b-9076-4b7de7d52edd"
}

variable "sysdig_service_principal_id" {
  type        = string
  description = "Sysdig Service Principal ID that customer will grant resource access to"
  default     = "a25af867-d32c-4746-8328-35ea1596c51c"
}

variable "is_tenant" {
  type        = bool
  description = "Whether this task is being created at the tenant or subscription level"
  default     = false
}
