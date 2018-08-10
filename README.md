# aws-terraform-iam_resources

This repository contains several terraform modules that can be used to deploy various IAM resources, such as IAM Roles, IAM Users, and IAM Groups.  It also contains specialised deployments of IAM resources, such as those required by AWS Systems Manager for Maintenance Windows and Automation.

## Module listing
- [role](./modules/role/) - A terraform module that can be used to create an IAM role and when appropriate, and IAM instance profile.  This module can create both cross account roles, and service roles.
- [ssm_service_roles](./modules/ssm_service_roles) - A terraform module to deploy the required IAM resources for AWS System Manager maintenance Windows and Automation.
- user_group - A terraform module to create an IAM group and arbitrary number of IAM users.
