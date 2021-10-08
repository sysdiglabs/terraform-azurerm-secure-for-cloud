
variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure-staging.sysdig.com/"
  description = "Sysdig's Secure API URL"
}

variable "verify_ssl" {
  type        = bool
  default     = true
  description = "Verify the SSL certificate of the Secure endpoint"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. . Use default value unless you need to install multiple instances"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.name)) && length(var.name) > 1 && length(var.name) <= 64
    error_message = "Must enter a naming up to 64 alphanumeric characters."
  }
  default = "sfc-cloudconnector"
}

variable "config_source" {
  type        = string
  default     = null
  description = "Path to a file that contains the contents of the configuration file to be saved in the bucket"
}

variable "config_content" {
  default     = null
  type        = string
  description = "Configuration contents for the file stored in the bucket"
}

variable "image" {
  type        = string
  default     = "quay.io/sysdig/cloud-connector:master"
  description = "Image of the cloud-connector to deploy"
}

variable "location" {
  type        = string
  description = "Zone where the stack will be deployed"
}

variable "azure_eventhub_connection_string" {
  type        = string
  description = "EventHub SAS policy connection string"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    product = "sysdig-secure-for-cloud"
  }
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID where apply the infrastructure"
}
