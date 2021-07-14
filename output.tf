output "bucket_name" {
  value       = aws_s3_bucket.bucket.id
  description = "The bucket name with a randomized suffix"
}

output "topic_arns" {
  value       = aws_sns_topic.topic[*].arn
  description = "The topic ARNs created (if any)"
}
