locals {
  cross_account_vars = {
    sns_topic = module.sns.topic_arn
  }
}

terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 3.0"
  region  = "us-west-2"
}

provider "random" {
  version = "~> 2.0"
}

resource "random_string" "external_id" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

module "sns" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-sns//?ref=v0.12.1"
  name   = "my-example-topic"
}

module "cross_account_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.0"

  name        = "MyCrossAccountRole"
  aws_account = ["794790922771"]
  external_id = random_string.external_id.result

  inline_policy       = [templatefile("${path.module}/cross_account_role_policy.json", local.cross_account_vars)]
  inline_policy_count = 1
}
