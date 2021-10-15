variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default = {
    Team = "Sysdig"
  }
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
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

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.name)) && length(var.name) > 1 && length(var.name) <= 64
    error_message = "Must enter a naming prefix up to 64 alphanumeric characters."
  }
}

variable "logs" {
  description = "List of log categories."
  type        = list(string)
  default     = ["Administrative", "Security", "ServiceHealth", "Alert", "Recommendation", "Policy", "Autoscale", "ResourceHealth"]
}
