terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.1"
  region  = "us-west-2"
}

module "ssm_service_roles" {
  source = "../../module/modules/ssm_service_roles"
}

