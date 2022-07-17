# ====================
#
# ElastiCache Replication Group
#
# ====================

resource "aws_elasticache_replication_group" "tf_elasticache_replication_group" {
  engine         = "redis"
  engine_version = var.cache_engine_version

  replication_group_id = "${var.system}-${var.project}-${var.environment}-cache-cluster"
  description          = "${var.system}-${var.project}-${var.environment}-cache-cluster"

  subnet_group_name  = aws_elasticache_subnet_group.tf_elasticache_subnet_group.name
  security_group_ids = [var.security_group_id]
  port               = 6379

  parameter_group_name = aws_elasticache_parameter_group.tf_elasticache_parameter_group.name

  multi_az_enabled           = true
  automatic_failover_enabled = true

  node_type               = var.cache_node_type
  num_node_groups         = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group

  snapshot_retention_limit = var.cache_snapshot_retention_limit
  snapshot_window          = var.cache_snapshot_window
  maintenance_window       = var.cache_maintenance_window

  auto_minor_version_upgrade = var.cache_auto_minor_version_upgrade

  apply_immediately = true

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-cache-cluster"
  }
}

# ====================
#
# ElastiCache Subnet Group
#
# ====================
resource "aws_elasticache_subnet_group" "tf_elasticache_subnet_group" {
  name = "${var.system}-${var.project}-${var.environment}-cache-subnetgroup"
  subnet_ids = [
    var.isolated_1a_subnet_id,
    var.isolated_1c_subnet_id
  ]

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-cache-subnetgroup"
  }
}

# ====================
#
# ElastiCache Parameter Group
#
# ====================
resource "aws_elasticache_parameter_group" "tf_elasticache_parameter_group" {
  name   = "${var.system}-${var.project}-${var.environment}-cache-parametergroup"
  family = "redis6.x"

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-cache-parametergroup"
  }
}
