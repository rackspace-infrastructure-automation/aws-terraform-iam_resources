provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "ssm_service_roles" {
  source = "../../module/modules/ssm_service_roles"
}
