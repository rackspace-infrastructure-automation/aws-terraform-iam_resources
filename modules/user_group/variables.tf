variable "existing_user_names" {
  description = "A list of existing IAM users.  These users will also  be added to the created group."
  type        = list(string)
  default     = []
}

variable "group_name" {
  description = "The name to assign to the IAM Group created for these users.  If omitted no group will be created."
  type        = string
  default     = ""
}

variable "policy_arns" {
  description = "A list of managed IAM policies to attach to the IAM group"
  type        = list(string)
  default     = []
}

variable "policy_arns_count" {
  description = "The number of managed policies to be applied to the role."
  type        = number
  default     = 0
}

variable "user_names" {
  description = "A list of user names.  A new IAM user will be created for each element of this list"
  type        = list(string)
  default     = []
}

