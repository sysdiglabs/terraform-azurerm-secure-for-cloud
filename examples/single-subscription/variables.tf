# Mandatory vars
variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

# Vars with defaults
variable "location" {
  type        = string
  default     = "us-central1"
  description = "Zone where the stack will be deployed"
}

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

variable "region" {
  type        = string
  description = "Region in which to run the benchmark. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}
