# ====================
#
# Outputs
#
# ====================

output "elasticache_endpoint" {
  value = aws_elasticache_replication_group.tf_elasticache_replication_group.configuration_endpoint_address
}
