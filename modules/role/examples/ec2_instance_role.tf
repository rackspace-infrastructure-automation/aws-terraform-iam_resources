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
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "ssm:GetParameter",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
    ]
    effect    = "Allow"
    resources = ["arn:aws:s3:::rackspace-*/*"]
  }
}

module "ec2_instance_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.5"

  name        = "EC2InstanceRole"
  aws_service = ["ec2.amazonaws.com"]

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  ]
  policy_arns_count = 2

  inline_policy       = [data.aws_iam_policy_document.ec2_instance_policy.json]
  inline_policy_count = 1
}
