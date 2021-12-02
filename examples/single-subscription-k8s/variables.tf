variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
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

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

#scanning
variable "deploy_scanning" {
  type        = bool
  description = "whether scanning module is to be deployed"
  default     = false
}

# benchmark
variable "deploy_benchmark" {
  type        = bool
  description = "whether benchmark module is to be deployed"
  default     = false
}

variable "region" {
  type        = string
  description = "Region in which to run benchmarks. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}


# general
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
  description = "The resource group name to deploy Secure for Cloud stack"
}

variable "cloud_connector_image" {
  type        = string
  description = "Cloud-connector image to deploy"
  default     = "quay.io/sysdig/cloud-connector"
}
