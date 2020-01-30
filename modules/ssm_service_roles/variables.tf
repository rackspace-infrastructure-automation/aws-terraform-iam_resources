variable "create_automation_role" {
  description = "A variable to control whether the Automation Service IAM role should be created"
  type        = bool
  default     = true
}

variable "create_maintenance_window_role" {
  description = "A variable to control whether the Maintenance Window Service IAM role should be created"
  type        = bool
  default     = true
}

