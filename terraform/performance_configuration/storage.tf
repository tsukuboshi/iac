resource "random_string" "example_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  number  = true
  special = false
}

# ====================
#
# S3 static bucket
#
# ====================

resource "aws_s3_bucket" "example_static_bucket" {
  bucket = "${var.project}-${var.environment}-static-bucket-${random_string.example_unique_key.result}"

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_public_access_block" "example_static_bucket" {
  bucket                  = aws_s3_bucket.example_static_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket_policy.example_static_bucket_policy,
  ]
}

resource "aws_s3_bucket_policy" "example_static_bucket_policy" {
  bucket = aws_s3_bucket.example_static_bucket.id
  policy = data.aws_iam_policy_document.example_static_bucket_policy_document.json
}

data "aws_iam_policy_document" "example_static_bucket_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.example_static_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.iam_arn]
    }
  }
}
