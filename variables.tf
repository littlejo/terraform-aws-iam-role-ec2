variable "name" {
  description = "Name of iam role"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix name of iam role"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of iam role"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "Assume role policy of iam role"
  type        = string
  default     = null
}

variable "path" {
  description = "Path of iam role"
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it"
  type        = bool
  default     = true
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

variable "managed_policy_arns" {
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role."
  type        = list(string)
  default     = null
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "inline_policies" {
  description = "Set of inline policies"
  type = list(object({
    name   = string
    policy = string
  }))
  default = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = null
}

variable "create_instance_profile" {
  description = "Create instance profile"
  type        = bool
  default     = true
}

variable "iam_policies" {
  description = "Set of inline policies"
  type = list(object({
    name        = string
    path        = optional(string)
    description = optional(string)
    policy      = string
    tags        = optional(map(string))
  }))
  default = []
}
