
variable "eventhub_endpoint_id" {
  type        = string
  description = "Specifies the id where the Event Hub is located"
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

variable "resource_group_name" {
  type        = string
  description = "The resource group name where the stack has been deployed"
}

variable "existing_registries" {
  type        = map(list(string))
  default     = {}
  description = "existing  Azure Container Registry names to be included to  scan by resource group { resource_group_1 =  [\"registry_name_11\",\"registry_name_12\"],resource_group_2 =  [\"registry_name_21\",\"registry_name_22\"]}. By default it will create a new ACR"
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
