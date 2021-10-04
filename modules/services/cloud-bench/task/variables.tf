// For single subscription
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

variable "is_tenant" {
  type        = bool
  description = "Whether this task is being created at the tenant or subscription level"
  default     = false
}

#---------------------------------
# optionals - with default
#---------------------------------

variable "region" {
  type        = string
  description = "Region in which to run the benchmark. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}
