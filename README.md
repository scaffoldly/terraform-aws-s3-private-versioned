[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-s3-private-versioned)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.0.0-blue.svg)

## Description

Create a private and versioned S3 bucket with optional SNS notifications

## Usage

```hcl
module "emails_bucket_live" {
  source = "scaffoldly/s3-private-versioned/aws"

  bucket_name_prefix = "emails-live"

  read_only_principals = [
    data.aws_iam_role.serverless_email_api_live.arn
  ]

  write_only_service = "ses.amazonaws.com"

  notification_prefixes = ["emails.mydomain.com/"]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.64.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_sns_topic.topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | A prefix name for the bucket | `string` | n/a | yes |
| <a name="input_notification_prefixes"></a> [notification\_prefixes](#input\_notification\_prefixes) | The object prefixes to create SNS notifications for (e.g. ['folder1/', 'folder2/'] or [''] for everything) | `list` | `[]` | no |
| <a name="input_read_only_principals"></a> [read\_only\_principals](#input\_read\_only\_principals) | The ARNs of users/roles/etc that have read-only access to the bucket | `list` | `[]` | no |
| <a name="input_read_write_principals"></a> [read\_write\_principals](#input\_read\_write\_principals) | The ARNs of users/roles/etc that have read-write access to the bucket | `list` | `[]` | no |
| <a name="input_root_principal"></a> [root\_principal](#input\_root\_principal) | The root prinicipal. In most cases leave this as 'root' | `string` | `"root"` | no |
| <a name="input_write_only_principals"></a> [write\_only\_principals](#input\_write\_only\_principals) | The ARNs of users/roles/etc that have write-only access to the bucket | `list` | `[]` | no |
| <a name="input_write_only_services"></a> [write\_only\_services](#input\_write\_only\_services) | The AWS services that have write-only access to the bucket (e.g. ses.amazonaws.com, lambda.amazonaws.com) | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The bucket name with a randomized suffix |
| <a name="output_topic_arns"></a> [topic\_arns](#output\_topic\_arns) | The topic ARNs created (if any) |
<!-- END_TF_DOCS -->
