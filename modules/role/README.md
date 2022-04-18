# aws-terraform-iam\_resources/modules/role

This submodule creates an IAM Role

## Basic Usage

```
module "ec2_instance_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.12.0"

  name        = "EC2InstanceRole"
  aws_service = ["ec2.amazonaws.com"]

  policy_arns       = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  policy_arns_count = 1

  inline_policy       = ["${data.aws_iam_policy_document.ec2_instance_policy.json}"]
  inline_policy_count = 1
}
```

Full working references are available at [examples](examples)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.7.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/2.7.0/docs/resources/iam_instance_profile) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/2.7.0/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/2.7.0/docs/resources/iam_role) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/2.7.0/docs/resources/iam_role_policy) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/2.7.0/docs/resources/iam_role_policy_attachment) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account | A list of AWS accounts allowed to use this cross account role.  Required if the aws\_services variable is not provided. | `list(string)` | `[]` | no |
| aws\_service | A list of AWS services allowed to assume this role.  Required if the aws\_accounts variable is not provided. | `list(string)` | `[]` | no |
| build\_state | A variable to control whether resources should be built | `bool` | `true` | no |
| external\_id | The external ID to be used for any cross account roles. | `string` | `""` | no |
| inline\_policy | A list of strings.  Each string should contain a json string to use for this inline policy | `list(string)` | `[]` | no |
| inline\_policy\_count | The number of inline policies to be applied to the role. | `number` | `0` | no |
| name | The name prefix for these IAM resources | `string` | n/a | yes |
| policy\_arns | A list of managed IAM policies to attach to the IAM role | `list(string)` | `[]` | no |
| policy\_arns\_count | The number of managed policies to be applied to the role. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | IAM role ARN |
| id | IAM role id |
| instance\_profile | IAM Instance Profile name |
| name | IAM role name |
