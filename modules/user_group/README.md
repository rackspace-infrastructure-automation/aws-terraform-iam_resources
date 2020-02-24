# aws-terraform-iam\_resources/modules/user\_group

This submodule creates an IAM User Group

## Basic Usage

```
module "user_4" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/user_group?ref=v0.0.1"

  user_names = ["testuser4a"]
}
```

Full working references are available at [examples](examples)

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| existing\_user\_names | A list of existing IAM users.  These users will also  be added to the created group. | `list(string)` | `[]` | no |
| group\_name | The name to assign to the IAM Group created for these users.  If omitted no group will be created. | `string` | `""` | no |
| policy\_arns | A list of managed IAM policies to attach to the IAM group | `list(string)` | `[]` | no |
| policy\_arns\_count | The number of managed policies to be applied to the role. | `number` | `0` | no |
| user\_names | A list of user names.  A new IAM user will be created for each element of this list | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_arn | IAM group ARN |
| group\_id | IAM group id |
| group\_name | IAM group name |
| user\_names | The list of created IAM users |

