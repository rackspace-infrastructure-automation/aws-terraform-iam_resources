terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ssm_service_roles" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/ssm_service_roles?ref=v0.12.0"
  # Optional parameters
  #
  # create_automation_role         = true
  # create_maintenance_window_role = true
}
