# ====================
#
# Outputs
#
# ====================

output "backup_role_arn" {
  value = aws_iam_role.tf_iam_role_backup.arn
}
