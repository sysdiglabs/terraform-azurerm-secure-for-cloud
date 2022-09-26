#---------------------------------
# optionals - with defaults
#---------------------------------

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
  description = "true/false, whether scanning module is to be deployed"
  default     = false
}

variable "existing_registries" {
  type        = map(list(string))
  default     = {}
  description = "existing  Azure Container Registry names to be included to  scan by resource group { resource_group_1 =  [\"registry_name_11\",\"registry_name_12\"],resource_group_2 =  [\"registry_name_21\",\"registry_name_22\"]}. By default it will create a new ACR"
}

#
# benchmark
#

variable "deploy_benchmark" {
  type        = bool
  description = "whether benchmark module is to be deployed"
  default     = true
}

variable "region" {
  type        = string
  description = "Region in which to run benchmarks. Azure accepts one of [AzureCloud, AzureChinaCloud, AzureGermanCloud, AzureUSGovernment]."
  default     = "AzureCloud"
}


#
# general
#

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
