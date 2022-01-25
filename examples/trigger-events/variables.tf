variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID to use to deploy the resources"
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
