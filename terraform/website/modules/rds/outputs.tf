# ====================
#
# Outputs
#
# ====================

output "rds_endpoint" {
  value = aws_db_instance.tf_db_instance.address
}
