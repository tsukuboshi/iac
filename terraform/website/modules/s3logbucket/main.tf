# ====================
#
# S3 Bucket
#
# ====================

data "aws_caller_identity" "tf_caller_identity" {}

resource "aws_s3_bucket" "tf_bucket_log" {
  bucket        = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-log-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.internal
}

resource "aws_s3_bucket_ownership_controls" "tf_bucket_ownership_controls_alb_log" {
  bucket = aws_s3_bucket.tf_bucket_log.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_alb_log" {
  bucket                  = aws_s3_bucket.tf_bucket_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle_configuration_alb_log" {
  bucket = aws_s3_bucket.tf_bucket_log.id
  rule {
    id = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-log-${data.aws_caller_identity.tf_caller_identity.account_id}-lifecycle"
    expiration {
      days = var.object_expiration_days
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning_log" {
  bucket = aws_s3_bucket.tf_bucket_log.id
  versioning_configuration {
    status = var.internal == true ? "Disabled" : "Enabled"
  }
}
