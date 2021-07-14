data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  root_arn            = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:${var.root_principal}"
  notification_topics = formatlist("s3-${var.bucket_name_prefix}-%s-notifications", var.notification_prefixes)

  read_only_principals = jsonencode(
    concat(
      [local.root_arn],
      var.read_only_principals
    )
  )

  read_write_principals = jsonencode(
    concat(
      [local.root_arn],
      var.read_write_principals
    )
  )

  write_only_principals = jsonencode(
    concat(
      [local.root_arn],
      var.write_only_principals
    )
  )
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_name_prefix
  acl           = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = templatefile("${path.module}/bucket_policy.json.tpl", {
    partition             = data.aws_partition.current.partition
    account               = data.aws_caller_identity.current.account_id
    bucket_name           = aws_s3_bucket.bucket.id
    read_only_principals  = local.read_only_principals
    read_write_principals = local.read_write_principals
    write_only_principals = local.write_only_principals
    write_only_services   = var.write_only_services
  })

  depends_on = [
    aws_s3_bucket_public_access_block.block
  ]
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "sns:Publish",
    ]

    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"

      values = [aws_s3_bucket.bucket.arn]
    }
  }
}

resource "aws_sns_topic" "topic" {
  count = length(local.notification_topics)

  name         = replace(replace(local.notification_topics[count.index], ".", "-"), "/[^a-zA-Z0-9_\\-]/", "")
  display_name = replace(replace(local.notification_topics[count.index], ".", "-"), "/[^a-zA-Z0-9_\\-]/", "")

  policy = data.aws_iam_policy_document.policy.json

  depends_on = [
    aws_s3_bucket_policy.policy
  ]
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count = length(local.notification_topics) > 0 ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "topic" {
    for_each = toset(var.notification_prefixes)

    content {
      topic_arn     = aws_sns_topic.topic[index(var.notification_prefixes, topic.key)].arn
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = topic.key
    }
  }
}

