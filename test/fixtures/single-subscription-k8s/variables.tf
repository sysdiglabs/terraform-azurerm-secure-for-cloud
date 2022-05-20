variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID used to deploy the resources"
}

variable "sysdig_secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
  sensitive   = true
}
