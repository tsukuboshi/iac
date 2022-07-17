# ====================
#
# Outputs
#
# ====================

output "rds_monitoring_role_arn" {
  value = aws_iam_role.tf_iam_role_rds.arn
}
