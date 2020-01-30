output "group_arn" {
  description = "IAM group ARN"
  value       = element(concat(aws_iam_group.group.*.arn, [""]), 0)
}

output "group_id" {
  description = "IAM group id"
  value       = element(concat(aws_iam_group.group.*.id, [""]), 0)
}

output "group_name" {
  description = "IAM group name"
  value       = element(concat(aws_iam_group.group.*.name, [""]), 0)
}

output "user_names" {
  description = "The list of created IAM users"
  value       = aws_iam_user.user.*.name
}

