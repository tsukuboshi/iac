# ====================
#
# Outputs
#
# ====================

output "iam_policy_arn" {
  value = data.aws_iam_policy.tf_iam_managed_policy.arn
}
