variable "targets_map" {
  type = map(string)

  default = {
    "/subscriptions/c3ea21a5-e474-4ed3-bf6c-b35fe3f9bea1" = true
  }
}

variable "logs" {
  description = "List of log categories to log."
  type        = list(string)
  default     = ["Administrative", "Security", "ServiceHealth", "Alert", "Recommendation", "Policy", "Autoscale", "ResourceHealth"]
}
