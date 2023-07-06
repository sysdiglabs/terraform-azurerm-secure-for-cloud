variable "subscription_id" {
  type        = string
  description = "Subscription ID in which to create a Trust Relationship"
}

#---------------------------------
# optionals - with default
#---------------------------------

variable "use_reader_role" {
  type        = bool
  description = "Set this flag to `true` to use the `Reader` role instead of the `Contributor` role. Some CSPM controls will not function correctly if this option is enabled"
  default     = false
}
