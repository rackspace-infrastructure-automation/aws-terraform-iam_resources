/* 
* # aws-terraform-iam_resources/modules/role
*
* This submodule creates an IAM Role
*
* ## Basic Usage
*
* ```
* module "ec2_instance_role" {
*   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.0"
*
*   name        = "EC2InstanceRole"
*   aws_service = ["ec2.amazonaws.com"]
*
*   policy_arns       = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"]
*   policy_arns_count = 1
*
*   inline_policy       = ["${data.aws_iam_policy_document.ec2_instance_policy.json}"]
*   inline_policy_count = 1
* }
* ```
*
* Full working references are available at [examples](examples)
*/

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.1.0"
  }
}

locals {
  assume_account = var.external_id == "" ? data.aws_iam_policy_document.assume_account.json : data.aws_iam_policy_document.assume_account_external_id.json
}

data "aws_iam_policy_document" "assume_account_external_id" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = var.aws_account
      type        = "AWS"
    }

    condition {
      test     = "StringEquals"
      values   = [var.external_id]
      variable = "sts:ExternalId"
    }
  }
}

data "aws_iam_policy_document" "assume_account" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = var.aws_account
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "assume_service" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      identifiers = var.aws_service
      type        = "Service"
    }
  }
}


resource "aws_iam_role" "role" {
  count = var.build_state ? 1 : 0

  assume_role_policy = length(var.aws_service) == 0 ? local.assume_account : data.aws_iam_policy_document.assume_service.json
  name_prefix        = "${var.name}-"
  path               = "/"
}


resource "aws_iam_role_policy" "role_policy" {
  count = var.build_state ? var.inline_policy_count : 0

  name   = "${var.name}InlinePolicy${count.index}"
  policy = element(var.inline_policy, count.index)
  role   = aws_iam_role.role[0].id
}


resource "aws_iam_role_policy_attachment" "attach_managed_policy" {
  count = var.build_state ? var.policy_arns_count : 0

  policy_arn = element(var.policy_arns, count.index)
  role       = aws_iam_role.role[0].name
}


resource "aws_iam_instance_profile" "instance_profile" {
  count = var.build_state && contains(var.aws_service, "ec2.amazonaws.com") ? 1 : 0

  name_prefix = aws_iam_role.role[0].name
  path        = "/"
  role        = aws_iam_role.role[0].name
}
