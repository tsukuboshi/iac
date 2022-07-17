# ====================
#
# Outputs
#
# ====================

output "bucket_name" {
  value = aws_s3_bucket.tf_bucket_log.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.tf_bucket_log.id
}

output "bucket_arn" {
  value = aws_s3_bucket.tf_bucket_log.arn
}
