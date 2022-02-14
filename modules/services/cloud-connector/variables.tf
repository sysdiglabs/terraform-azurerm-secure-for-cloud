
variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}

variable "sysdig_secure_endpoint" {
  type        = string
  default     = "https://secure.sysdig.com/"
  description = "Sysdig's Secure API URL"
}

variable "verify_ssl" {
  type        = bool
  default     = true
  description = "Verify the SSL certificate of the Secure endpoint"
}

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.name)) && length(var.name) > 1 && length(var.name) <= 64
    error_message = "Must enter a naming up to 64 alphanumeric characters."
  }
  default = "sfc-connector"
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
  default     = "quay.io/sysdig/cloud-connector:latest"
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

variable "azure_eventgrid_eventhub_connection_string" {
  type        = string
  description = "EventHub SAS policy connection string for event grid"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
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

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    product = "sysdig-secure-for-cloud"
  }
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID where deploy the cloud connector image"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "client_id" {
  type        = string
  description = "Enterprise application ID"
}

variable "client_secret" {
  type        = string
  description = "Enterprise application service principal secret"
}

variable "container_registry" {
  type        = string
  description = "Azure container registry name to run acr quick task for inline scanning"
}

variable "deploy_scanning" {
  type        = bool
  description = "whether scanning module is to be deployed"
  default     = false
}
