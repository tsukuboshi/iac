# ====================
#
# Outputs
#
# ====================

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.tf_ecs_cluster.arn
}
