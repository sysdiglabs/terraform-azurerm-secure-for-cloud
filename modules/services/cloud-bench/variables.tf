# For single project
variable "subscription_id" {
  type        = string
  description = "Subscription ID in which to create a Trust Relationship"
  default     = ""
}

# For tenant
variable "subscription_ids" {
  type        = list(string)
  description = "List of Subscription IDs in which to create a Trust Relationship"
  default     = []
}

#---------------------------------
# optionals - with default
#---------------------------------

variable "is_tenant" {
  type        = bool
  description = "Whether this task is being created at the tenant or subscription level"
  default     = false
}

variable "use_reader_role" {
  type        = bool
  description = "Set this flag to `true` to use the `Reader` role instead of the `Contributor` role. Some CSPM controls will not function correctly if this option is enabled"
  default     = false
}