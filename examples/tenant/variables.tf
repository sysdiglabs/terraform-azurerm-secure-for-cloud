# Mandatory vars
variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}


## Vars with defaults
variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.name)) && length(var.name) > 1 && length(var.name) <= 64
    error_message = "Must enter a naming up to 64 alphanumeric characters."
  }
  default = "sfc"
}

variable "location" {
  type        = string
  default     = "westus"
  description = "Zone where the stack will be deployed"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    product = "sysdig-secure-for-cloud"
  }
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The resource group name to deploy cloud vision stack"
}

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

variable "region" {
  type        = string
  description = "Region in which to run benchmarks. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}

variable "benchmark_subscription_ids" {
  default     = []
  type        = list(string)
  description = "Azure subscription IDs to run Benchmarks on. If no subscriptions are specified, all of the tenant will be used."
}

variable "threat_detection_subscription_ids" {
  default     = []
  type        = list(string)
  description = "Azure subscription IDs to run threat detection on. If no subscriptions are specified, all of the tenant will be used."
}

variable "deploy_bench" {
  type        = bool
  description = "whether benchmark module is to be deployed"
  default     = true
}
