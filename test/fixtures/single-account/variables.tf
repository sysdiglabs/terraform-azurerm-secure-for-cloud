variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID to use to deploy the resources"
}

variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID to use to deploy the resources"
}


variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}
