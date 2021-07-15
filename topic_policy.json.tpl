{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket-publish",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "sns:Publish"
      ],
      "Resource": "${topic_arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "${bucket_arn}"
        }
      }
    },
    {
      "Sid": "read-only",
      "Effect": "Allow",
      "Principal": {
        "AWS": ${read_only_principals}
      },
      "Action": [
        "sns:Subscribe"
      ],
      "Resource": "${topic_arn}"
    },
    {
      "Sid": "read-write",
      "Effect": "Allow",
      "Principal": {
        "AWS": ${read_write_principals}
      },
      "Action": [
        "sns:Subscribe",
        "sns:Publish"
      ],
      "Resource": "${topic_arn}"
    },
    {
      "Sid": "write-only",
      "Effect": "Allow",
      "Principal": {
        "AWS": ${write_only_principals}
      },
      "Action": [
        "sns:Publish"
      ],
      "Resource": "${topic_arn}"
    }
  ]
}