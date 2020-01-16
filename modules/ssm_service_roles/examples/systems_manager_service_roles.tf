provider "aws" {
  version = ">= 2.1.0"
  region  = "us-west-2"
}

module "ssm_service_roles" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/ssm_service_roles?ref=v0.0.1"
  # Optional parameters
  #
  # create_automation_role         = true
  # create_maintenance_window_role = true
}

