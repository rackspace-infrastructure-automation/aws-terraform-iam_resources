locals {
  cross_account_vars = {
    sns_topic = module.sns.topic_arn
  }
}

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
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.5"

  name        = "MyCrossAccountRole"
  aws_account = ["794790922771"]
  external_id = random_string.external_id.result

  inline_policy       = [templatefile("${path.module}/cross_account_role_policy.json", local.cross_account_vars)]
  inline_policy_count = 1
}
