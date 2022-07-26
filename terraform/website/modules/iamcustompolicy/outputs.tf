# ====================
#
# Outputs
#
# ====================

output "iam_policy_arn" {
  value = aws_iam_policy.tf_iam_custom_policy.arn
}
