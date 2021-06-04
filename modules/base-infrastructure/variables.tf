variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    Team = "Sysdig"
  }
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID where apply the infrastructure"
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "Pricing tier plan [Basic, Standard, Premium]"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Zone where the stack will be deployed"
}

variable "namespace_capacity" {
  type        = number
  default     = 1
  description = "Processing units or throughput units are pre-purchased units of capacity"
}

variable "eventhub_partition_count" {
  type        = number
  default     = 1
  description = "The partition count setting allows you to parallelize consumption across many consumers"
}

variable "eventhub_retention_days" {
  type        = number
  default     = 1
  description = "The message retention setting specifies how long the Event Hubs service keeps data"
}

variable "naming_prefix" {
  type        = string
  description = "Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.naming_prefix)) && length(var.naming_prefix) > 1 && length(var.naming_prefix) <= 64
    error_message = "Must enter a naming prefix up to 64 alphanumeric characters."
  }
}

variable "logs" {
  description = "List of log categories to log."
  type        = list(string)
  default     = ["Administrative", "Security", "ServiceHealth", "Alert", "Recommendation", "Policy", "Autoscale", "ResourceHealth"]
}
