provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

provider "template" {
  version = "~> 1.0"
}

provider "random" {
  version = "~> 1.0"
}

resource "random_string" "external_id" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

module "sns" {
  source     = "git@github.com:rackspace-infrastructure-automation/aws-terraform-sns//?ref=v0.0.1"
  topic_name = "my-example-topic"
}

data "template_file" "cross_account_role" {
  template = "${file("${path.module}/cross_account_role_policy.json")}"

  vars = {
    sns_topic = "${module.sns.topic_arn}"
  }
}

module "cross_account_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.0.1"

  name        = "MyCrossAccountRole"
  aws_account = ["794790922771"]
  external_id = "${random_string.external_id.result}"

  inline_policy       = ["${data.template_file.cross_account_role.rendered}"]
  inline_policy_count = 1
}
