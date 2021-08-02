variable "naming_prefix" {
  type        = string
  description = "Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.naming_prefix)) && length(var.naming_prefix) > 1 && length(var.naming_prefix) <= 64
    error_message = "Must enter a naming prefix up to 64 alphanumeric characters."
  }
  default = "cloudconn"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID where apply the infrastructure"
}

variable "eventhub_connection_string" {
  type        = string
  description = "The eventhub connection string"
}

variable "cloudconnector_deploy" {
  type        = bool
  default     = false
  description = "Whether to deploy or not CloudConnector"
}

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com"
  description = "Sysdig Secure API endpoint"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Zone where the stack will be deployed"
}

variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    Team = "CloudVision"
  }
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
}
