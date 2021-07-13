[![Maintained by Scaffoldly](https://img.shields.io/badge/maintained%20by-scaffoldly-blueviolet)](https://github.com/scaffoldly)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/scaffoldly/terraform-aws-s3-private-versioned)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.15.0-blue.svg)

## Description

Create a private and versioned S3 bucket with optional SNS notifications

## Usage

```hcl
module "emails_bucket_live" {
  source = "scaffoldly/s3-private-versioned/aws"

  name = "emails-live"

  read_only_principals = [
    data.aws_iam_role.serverless_email_api_live.arn
  ]

  write_only_service = "ses.amazonaws.com"

  notification_prefixes = ["emails.mydomain.com/"]
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

## Providers

## Modules

## Resources

## Inputs

## Outputs

<!-- END_TF_DOCS -->
