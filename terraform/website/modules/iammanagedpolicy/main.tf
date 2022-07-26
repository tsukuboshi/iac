# ====================
#
# IAM Managed Policy
#
# ====================

data "aws_iam_policy" "tf_iam_managed_policy" {
  arn = var.iam_role_policy_arn
}
