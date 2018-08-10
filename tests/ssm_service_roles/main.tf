provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "ssm_service_roles" {
  source = "../../module/ssm_service_roles"
}

output "service_role_details" {
  description = "SSM Service Role details"
  value       = "${module.ssm_service_roles.module_details}"
}
