locals {
  assume_account = "${var.external_id == "" ?
                      data.aws_iam_policy_document.assume_account.json :
                      data.aws_iam_policy_document.assume_account_external_id.json}"
}

data "aws_iam_policy_document" "assume_account_external_id" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = "${var.aws_account}"
    }

    condition = {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["${var.external_id}"]
    }
  }
}

data "aws_iam_policy_document" "assume_account" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = "${var.aws_account}"
    }
  }
}

data "aws_iam_policy_document" "assume_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = "${var.aws_service}"
    }
  }
}

resource "aws_iam_role" "role" {
  count = "${var.build_state ? 1 : 0}"

  name_prefix        = "${var.name}-"
  path               = "/"
  assume_role_policy = "${length(var.aws_service) == 0 ? local.assume_account :  data.aws_iam_policy_document.assume_service.json}"
}

resource "aws_iam_role_policy" "role_policy" {
  count = "${var.build_state ? var.inline_policy_count : 0}"

  name   = "${var.name}InlinePolicy${count.index}"
  role   = "${aws_iam_role.role.id}"
  policy = "${element(var.inline_policy, count.index)}"
}

resource "aws_iam_role_policy_attachment" "attach_managed_policy" {
  count = "${var.build_state ? var.policy_arns_count : 0}"

  role       = "${aws_iam_role.role.name}"
  policy_arn = "${element(var.policy_arns, count.index)}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = "${var.build_state && contains(var.aws_service, "ec2.amazonaws.com") ? 1 : 0}"

  name_prefix = "${aws_iam_role.role.name}"
  role        = "${aws_iam_role.role.name}"
  path        = "/"
}
