
variable "eventhub_endpoint_id" {
  type        = string
  default     = "/subscriptions/bfc31cc5-d3bd-4b36-a40e-d13688d546ec/resourceGroups/egigroup/providers/Microsoft.EventHub/namespaces/cloudconnector-eventhub-namespace/eventhubs/cloudconnector-eventhub"
  description = "Specifies the id where the Event Hub is located"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "Pricing tier plan [Basic, Standard, Premium]"
}

variable "location" {
  type        = string
  default     = "westus"
  description = "Zone where the stack will be deployed"
}

variable "admin_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether the admin user is enabled"
}

variable "georeplication" {
  description = "A list of Azure locations where the container registry should be geo-replicated"
  type        = list(string)
  default     = ["centralus"]
}

variable "naming_prefix" {
  type        = string
  description = "Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.naming_prefix)) && length(var.naming_prefix) > 1 && length(var.naming_prefix) <= 64
    error_message = "Must enter a naming prefix up to 64 alphanumeric characters."
  }
}
