/**
* # aws-terraform-iam_resources/modules/role
*
*This submodule creates an IAM Role
*
*## Basic Usage
*
*```
*module "ec2_instance_role" {
*  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.0.1"
*
*  name        = "EC2InstanceRole"
*  aws_service = ["ec2.amazonaws.com"]
*
*  policy_arns       = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"]
*  policy_arns_count = 1
*
*  inline_policy       = ["${data.aws_iam_policy_document.ec2_instance_policy.json}"]
*  inline_policy_count = 1
*}
*```
*
* Full working references are available at [examples](examples)
*/

terraform {
  required_version = ">= 0.12"
}

locals {
  assume_account = var.external_id == "" ? data.aws_iam_policy_document.assume_account.json : data.aws_iam_policy_document.assume_account_external_id.json
}

data "aws_iam_policy_document" "assume_account_external_id" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.aws_account
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  }
}

data "aws_iam_policy_document" "assume_account" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.aws_account
    }
  }
}

data "aws_iam_policy_document" "assume_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.aws_service
    }
  }
}


resource "aws_iam_role" "role" {
  count = var.build_state ? 1 : 0

  name_prefix        = "${var.name}-"
  path               = "/"
  assume_role_policy = length(var.aws_service) == 0 ? local.assume_account : data.aws_iam_policy_document.assume_service.json
}


resource "aws_iam_role_policy" "role_policy" {
  count = var.build_state ? var.inline_policy_count : 0

  name   = "${var.name}InlinePolicy${count.index}"
  role   = aws_iam_role.role[0].id
  policy = element(var.inline_policy, count.index)
}


resource "aws_iam_role_policy_attachment" "attach_managed_policy" {
  count = var.build_state ? var.policy_arns_count : 0

  role       = aws_iam_role.role[0].name
  policy_arn = element(var.policy_arns, count.index)
}


resource "aws_iam_instance_profile" "instance_profile" {
  count = var.build_state && contains(var.aws_service, "ec2.amazonaws.com") ? 1 : 0

  name_prefix = aws_iam_role.role[0].name
  role        = aws_iam_role.role[0].name
  path        = "/"
}


