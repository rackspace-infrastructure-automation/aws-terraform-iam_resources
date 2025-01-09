# aws-terraform-iam\_resources/modules/ssm\_service\_roles

This submodule creates an IAM Role for the SSM Services

## Basic Usage

```
module "ssm_service_roles" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/ssm_service_roles?ref=v0.12.0"

  # Optional parameters
  #
  # create_automation_role         = true
  # create_maintenance_window_role = true
}
```

Full working references are available at [examples](examples)

## Requirements

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| automation_role | ../role |  |
| maintenance_window_role | ../role |  |

## Resources

| Name |
|------|
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/4.0/docs/data-sources/iam_policy_document) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/4.0/docs/resources/iam_role_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_automation\_role | A variable to control whether the Automation Service IAM role should be created | `bool` | `true` | no |
| create\_maintenance\_window\_role | A variable to control whether the Maintenance Window Service IAM role should be created | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| automation\_arn | Automation Service IAM role ARN |
| automation\_id | Automation Service IAM role id |
| automation\_instance\_profile | Automation Service IAM Instance Profile name |
| automation\_name | Automation Service IAM role name |
| maintenance\_window\_arn | Maintenance Window IAM role ARN |
| maintenance\_window\_id | Maintenance Window IAM role id |
| maintenance\_window\_instance\_profile | Maintenance Window IAM Instance Profile name |
| maintenance\_window\_name | Maintenance Window IAM role name |
| module\_details | All details about created SSM Service Roles |
