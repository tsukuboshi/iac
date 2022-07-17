# ====================
#
# S3 Bucket Policy
#
# ====================

data "aws_caller_identity" "tf_caller_identity" {}

data "aws_elb_service_account" "tf_log_service_account" {}

data "aws_iam_policy_document" "tf_iam_policy_document_alb_log" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.tf_log_service_account.id}:root"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.access_log_bucket_name}/${var.access_log_prefix}/AWSLogs/${data.aws_caller_identity.tf_caller_identity.account_id}/*"]
  }
}

resource "aws_s3_bucket_policy" "tf_bucket_policy_alb_log" {
  bucket = var.access_log_bucket_id
  policy = data.aws_iam_policy_document.tf_iam_policy_document_alb_log.json
}
