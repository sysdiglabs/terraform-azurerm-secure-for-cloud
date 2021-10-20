variable "subscription_id" {
  type        = string
  description = "ID of subscription containing resources to run benchmarks on"
}

#---------------------------------
# optionals - with default
#---------------------------------

variable "region" {
  type        = string
  description = "Region in which to run the benchmark. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}
