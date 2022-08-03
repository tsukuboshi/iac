# ====================
#
# Outputs
#
# ====================

output "iam_role_arn" {
  value = aws_iam_role.tf_iam_role.arn
}

output "iam_role_name" {
  value = aws_iam_role.tf_iam_role.name
}
