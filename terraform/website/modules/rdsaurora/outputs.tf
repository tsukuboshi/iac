# ====================
#
# Outputs
#
# ====================

output "aurora_endpoint" {
  value = aws_rds_cluster.tf_rds_cluster.endpoint
}
