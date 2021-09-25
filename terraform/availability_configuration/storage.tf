resource "random_string" "example_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  number  = true
  special = false
}

# ====================
#
# S3 log bucket
#
# ====================

resource "aws_s3_bucket" "example_log_bucket" {
  bucket        = "${var.project}-${var.environment}-log-bucket-${random_string.example_unique_key.result}"
  force_destroy = true

  lifecycle_rule {
    enabled = true

    expiration {
      days = var.expiration_days
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name    = "${var.project}-${var.environment}-log-bucket"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "example_log_bucket_access_block" {
  bucket                  = aws_s3_bucket.example_log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket_policy.example_log_bucket_policy]
}

resource "aws_s3_bucket_policy" "example_log_bucket_policy" {
  bucket = aws_s3_bucket.example_log_bucket.id
  policy = data.aws_iam_policy_document.example_log_bucket_policy_document.json
}

data "aws_iam_policy_document" "example_log_bucket_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.example_log_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.example_log_service_account.id]
    }
  }
}
