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

data "aws_iam_policy_document" "vpc_peer_cross_account_role" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:AcceptVpcPeeringConnection"]
    resources = ["*"]
  }
}

module "cross_account_role" {
  source = "../../module/modules/role"

  name        = "MyCrossAccountRole"
  aws_account = ["794790922771"]
  external_id = random_string.external_id.result

  inline_policy       = [templatefile("${path.module}/cross_account_role_policy.json", {})]
  inline_policy_count = 1
}

module "vpc_peer_cross_account_role" {
  source = "../../module/modules/role"

  name        = "VPCPeerCrossAccountRole"
  aws_account = ["794790922771"]

  inline_policy       = [data.aws_iam_policy_document.vpc_peer_cross_account_role.json]
  inline_policy_count = 1
}

data "aws_iam_policy_document" "ec2_instance_policy" {
  statement {
    effect    = "Allow"
    actions   = ["cloudformation:Describe"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ssm:CreateAssociation",
      "ssm:DescribeInstanceInformation",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "logs:CreateLogStream",
      "ec2:DescribeTags",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "ssm:GetParameter",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeTags"]
    resources = ["*"]
  }
}

module "ec2_instance_role" {
  source = "../../module/modules/role"

  name        = "EC2InstanceRole"
  aws_service = ["ec2.amazonaws.com"]

  policy_arns       = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  policy_arns_count = 1

  inline_policy       = [data.aws_iam_policy_document.ec2_instance_policy.json]
  inline_policy_count = 1
}
