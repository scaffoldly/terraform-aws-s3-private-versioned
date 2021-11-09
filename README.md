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

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.15 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 3.49.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                        | resource    |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource    |
| [aws_s3_bucket_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                          | resource    |
| [aws_s3_bucket_public_access_block.block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource    |
| [aws_sns_topic.topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                         | resource    |
| [aws_sns_topic_policy.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy)                       | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                        | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                 | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition)                                    | data source |

## Inputs

| Name                                                                                             | Description                                                                                                | Type     | Default  | Required |
| ------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------- | -------- | -------- | :------: |
| <a name="input_bucket_name_prefix"></a> [bucket_name_prefix](#input_bucket_name_prefix)          | A prefix name for the bucket                                                                               | `string` | n/a      |   yes    |
| <a name="input_notification_prefixes"></a> [notification_prefixes](#input_notification_prefixes) | The object prefixes to create SNS notifications for (e.g. ['folder1/', 'folder2/'] or [''] for everything) | `list`   | `[]`     |    no    |
| <a name="input_read_only_principals"></a> [read_only_principals](#input_read_only_principals)    | The ARNs of users/roles/etc that have read-only access to the bucket                                       | `list`   | `[]`     |    no    |
| <a name="input_read_write_principals"></a> [read_write_principals](#input_read_write_principals) | The ARNs of users/roles/etc that have read-write access to the bucket                                      | `list`   | `[]`     |    no    |
| <a name="input_root_principal"></a> [root_principal](#input_root_principal)                      | The root prinicipal. In most cases leave this as 'root'                                                    | `string` | `"root"` |    no    |
| <a name="input_write_only_principals"></a> [write_only_principals](#input_write_only_principals) | The ARNs of users/roles/etc that have write-only access to the bucket                                      | `list`   | `[]`     |    no    |
| <a name="input_write_only_services"></a> [write_only_services](#input_write_only_services)       | The AWS services that have write-only access to the bucket (e.g. ses.amazonaws.com, lambda.amazonaws.com)  | `list`   | `[]`     |    no    |

## Outputs

| Name                                                                 | Description                              |
| -------------------------------------------------------------------- | ---------------------------------------- |
| <a name="output_bucket_name"></a> [bucket_name](#output_bucket_name) | The bucket name with a randomized suffix |
| <a name="output_topic_arns"></a> [topic_arns](#output_topic_arns)    | The topic ARNs created (if any)          |

<!-- END_TF_DOCS -->
