variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}

#---------------------------------
# optionals - with defaults
#---------------------------------

variable "deploy_cloud_connector_module" {
  type        = bool
  description = "whether cloud-connector module and requirements are to be deployed. TODO enable deploy_thread_detection option"
  default     = false
}

variable "location" {
  type        = string
  default     = "westus"
  description = "Zone where the stack will be deployed"
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The resource group name to deploy secure for cloud stack"
}

variable "threat_detection_subscription_ids" {
  default     = []
  type        = list(string)
  description = "Azure subscription IDs to run threat detection on. If no subscriptions are specified, all of the tenant will be used."
}

variable "cpu" {
  type        = string
  default     = "0.5"
  description = "Number of CPU cores of the containers"
}

variable "memory" {
  type        = string
  default     = "1"
  description = "Number of CPU cores of the containers"
}

variable "deploy_active_directory" {
  type        = bool
  default     = true
  description = "whether the Active Directory features are to be deployed"
}


#
# scanning
#

variable "deploy_scanning" {
  type        = bool
  description = "whether scanning module is to be deployed"
  default     = true
}

variable "registry_name" {
  type        = string
  default     = ""
  description = "The existing Container Registry name"
}

variable "registry_resource_group_name" {
  type        = string
  default     = ""
  description = "The existing Container Registry name resource group name when is different than workload resource group name"
}


#
# benchmark
#
variable "deploy_benchmark" {
  type        = bool
  description = "whether benchmark module is to be deployed"
  default     = true
}

variable "benchmark_subscription_ids" {
  default     = []
  type        = list(string)
  description = "Azure subscription IDs to run Benchmarks on. If no subscriptions are specified, all of the tenant will be used."
}

variable "region" {
  type        = string
  description = "Region in which to run benchmarks. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}


#
# general
#

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.name)) && length(var.name) > 1 && length(var.name) <= 64
    error_message = "Must enter a naming up to 64 alphanumeric characters."
  }
  default = "sfc"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    product = "sysdig-secure-for-cloud"
  }
}
