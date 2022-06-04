# ====================
#
# ElastiCache Replication Group
#
# ====================

resource "aws_elasticache_replication_group" "tf_elasticache_replication_group" {
  engine         = "redis"
  engine_version = "6.2"

  replication_group_id = "${var.project}-${var.environment}-cluster"
  description          = "${var.project}-${var.environment}-cluster"

  subnet_group_name  = aws_elasticache_subnet_group.tf_elasticache_subnet_group.name
  security_group_ids = [aws_security_group.tf_sg_elasticache.id]
  port               = 6379

  parameter_group_name = aws_elasticache_parameter_group.tf_elasticache_parameter_group.name

  multi_az_enabled           = var.cache_multi_az_enabled
  automatic_failover_enabled = var.cache_automatic_failover_enabled

  node_type               = var.cache_node_type
  num_node_groups         = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group

  snapshot_retention_limit = var.cache_snapshot_retention_limit
  snapshot_window          = var.cache_snapshot_window
  maintenance_window       = var.cache_maintenance_window

  auto_minor_version_upgrade = var.cache_auto_minor_version_upgrade

  apply_immediately = var.cache_apply_immediately

  tags = {
    Name = "${var.project}-${var.environment}-elasticache-cluster"
  }
}

# ====================
#
# ElastiCache Subnet Group
#
# ====================
resource "aws_elasticache_subnet_group" "tf_elasticache_subnet_group" {
  name = "${var.project}-${var.environment}-cache-subnetgroup"
  subnet_ids = [
    aws_subnet.tf_subnet_5.id,
    aws_subnet.tf_subnet_6.id
  ]
}

# ====================
#
# ElastiCache Parameter Group
#
# ====================
resource "aws_elasticache_parameter_group" "tf_elasticache_parameter_group" {
  name   = "${var.project}-${var.environment}-cache-parametergroup"
  family = "redis6.x"

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}
