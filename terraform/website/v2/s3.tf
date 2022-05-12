data "aws_caller_identity" "tf_caller_identity" {}

# ====================
#
# S3 bucket
#
# ====================

#ALBログ用バケット
resource "aws_s3_bucket" "tf_bucket_alb_log" {
  bucket        = "${var.project}-${var.environment}-alblogs-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_ownership_controls" "tf_bucket_ownership_controls_alb_log" {
  bucket = aws_s3_bucket.tf_bucket_alb_log.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_alb_log" {
  bucket                  = aws_s3_bucket.tf_bucket_alb_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket_policy.tf_bucket_policy_alb_log]
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle_configuration_alb_log" {
  bucket = aws_s3_bucket.tf_bucket_alb_log.id
  rule {
    id = "log"
    expiration {
      days = var.expiration_days
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "tf_bucket_policy_alb_log" {
  bucket = aws_s3_bucket.tf_bucket_alb_log.id
  policy = data.aws_iam_policy_document.tf_iam_policy_document_alb_log.json
}

data "aws_iam_policy_document" "tf_iam_policy_document_alb_log" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.tf_log_service_account.id}:root"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.tf_bucket_alb_log.bucket}/${var.alb_log_prefix}/AWSLogs/${data.aws_caller_identity.tf_caller_identity.account_id}/*"]
  }

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.tf_bucket_alb_log.bucket}/${var.alb_log_prefix}/AWSLogs/${data.aws_caller_identity.tf_caller_identity.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.tf_bucket_alb_log.bucket}"]
  }
}


#VPCフローログ用バケット
resource "aws_s3_bucket" "tf_bucket_vpc_log" {
  bucket        = "${var.project}-${var.environment}-vpclogs-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_ownership_controls" "tf_bucket_ownership_controls_vpc_log" {
  bucket = aws_s3_bucket.tf_bucket_vpc_log.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_vpc_log" {
  bucket                  = aws_s3_bucket.tf_bucket_vpc_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle_configuration_vpc_log" {
  bucket = aws_s3_bucket.tf_bucket_vpc_log.id
  rule {
    id = "log"
    expiration {
      days = var.expiration_days
    }
    status = "Enabled"
  }
}

#WAFログ用バケット
resource "aws_s3_bucket" "tf_bucket_waf_log" {
  bucket        = "aws-waf-logs-${var.project}-${var.environment}-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_ownership_controls" "tf_bucket_ownership_controls_waf_log" {
  bucket = aws_s3_bucket.tf_bucket_waf_log.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_waf_log" {
  bucket                  = aws_s3_bucket.tf_bucket_waf_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle_configuration_waf_log" {
  bucket = aws_s3_bucket.tf_bucket_waf_log.id
  rule {
    id = "log"
    expiration {
      days = var.expiration_days
    }
    status = "Enabled"
  }
}

#CloudFrontログ用バケット
resource "aws_s3_bucket" "tf_bucket_cf_log" {
  bucket        = "aws-cf-logs-${var.project}-${var.environment}-${data.aws_caller_identity.tf_caller_identity.account_id}"
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_public_access_block" "tf_public_access_block_cf_log" {
  bucket                  = aws_s3_bucket.tf_bucket_cf_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_bucket_lifecycle_configuration_cf_log" {
  bucket = aws_s3_bucket.tf_bucket_cf_log.id
  rule {
    id = "log"
    expiration {
      days = var.expiration_days
    }
    status = "Enabled"
  }
}
