variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy cloud vision stack"
}
