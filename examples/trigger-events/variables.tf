variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID to use to deploy the resources"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
}

variable "location" {
  type        = string
  default     = "westus"
  description = "Zone where the stack will be deployed"
}
