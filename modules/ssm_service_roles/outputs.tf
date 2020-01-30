output "automation_arn" {
  description = "Automation Service IAM role ARN"
  value       = module.automation_role.arn
}

output "automation_id" {
  description = "Automation Service IAM role id"
  value       = module.automation_role.id
}

output "automation_instance_profile" {
  description = "Automation Service IAM Instance Profile name"
  value       = module.automation_role.instance_profile
}

output "automation_name" {
  description = "Automation Service IAM role name"
  value       = module.automation_role.name
}

output "maintenance_window_arn" {
  description = "Maintenance Window IAM role ARN"
  value       = module.maintenance_window_role.arn
}

output "maintenance_window_id" {
  description = "Maintenance Window IAM role id"
  value       = module.maintenance_window_role.id
}

output "maintenance_window_instance_profile" {
  description = "Maintenance Window IAM Instance Profile name"
  value       = module.maintenance_window_role.instance_profile
}

output "maintenance_window_name" {
  description = "Maintenance Window IAM role name"
  value       = module.maintenance_window_role.name
}

output "module_details" {
  description = "All details about created SSM Service Roles"

  value = {
    "automation_arn"                      = module.automation_role.arn
    "automation_id"                       = module.automation_role.id
    "automation_name"                     = module.automation_role.name
    "automation_instance_profile"         = module.automation_role.instance_profile
    "maintenance_window_arn"              = module.maintenance_window_role.arn
    "maintenance_window_id"               = module.maintenance_window_role.id
    "maintenance_window_name"             = module.maintenance_window_role.name
    "maintenance_window_instance_profile" = module.maintenance_window_role.instance_profile
  }
}

