provider "aws" {
  version = ">= 2.1.0"
  region  = "us-west-2"
}

module "ssm_service_roles" {
  source = "../../module/modules/ssm_service_roles"
}

