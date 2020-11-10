terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

module "user_1" {
  source = "../../module/modules//user_group"

  user_names        = ["testuser1a", "testuser1b", "testuser1c"]
  group_name        = "testgroup1"
  policy_arns       = ["arn:aws:iam::aws:policy/job-function/NetworkAdministrator"]
  policy_arns_count = 1
}

# New users and adding existing users from another module
module "user_2" {
  source = "../../module/modules/user_group"

  user_names          = ["testuser2a", "testuser2b"]
  group_name          = "testgroup2"
  policy_arns         = ["arn:aws:iam::aws:policy/PowerUserAccess"]
  policy_arns_count   = 1
  existing_user_names = module.user_1.user_names
}

# New users and adding existing users from two other modules
module "user_3" {
  source = "../../module/modules/user_group"

  user_names          = ["testuser3a", "testuser3b"]
  group_name          = "testgroup3"
  policy_arns         = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  policy_arns_count   = 1
  existing_user_names = concat(module.user_1.user_names, module.user_2.user_names)
}

# User with no group
module "user_4" {
  source = "../../module/modules/user_group"

  user_names = ["testuser4a"]
}

