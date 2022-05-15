# ====================
#
# RDS Cluster
#
# ====================
resource "aws_rds_cluster" "tf_rds_cluster" {
  cluster_identifier              = "${var.project}-${var.environment}-rds-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.01.0"
  db_subnet_group_name            = aws_db_subnet_group.tf_db_subnet_group.name
  vpc_security_group_ids          = [aws_security_group.tf_sg_rds.id]
  master_username                 = var.db_root_name
  master_password                 = var.db_root_pass
  port                            = 3306
  storage_encrypted               = var.storage_encrypted
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.backup_window
  preferred_maintenance_window    = var.maintenance_window
  enabled_cloudwatch_logs_exports = ["error", "slowquery", "audit", "general"]
  deletion_protection             = var.deletion_protection

  skip_final_snapshot = var.skip_final_snapshot
  apply_immediately   = var.apply_immediately

  tags = {
    Name = "${var.project}-${var.environment}-rds-cluster"
  }
}

# ====================
#
# RDS Instance
#
# ====================
resource "aws_rds_cluster_instance" "tf_rds_cluster_instance" {
  count                                 = 1
  engine                                = aws_rds_cluster.tf_rds_cluster.engine
  engine_version                        = aws_rds_cluster.tf_rds_cluster.engine_version
  cluster_identifier                    = aws_rds_cluster.tf_rds_cluster.id
  identifier                            = "${var.project}-${var.environment}-rds-instance-1a"
  availability_zone                     = var.availability_zone_1
  instance_class                        = var.instance_class
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  monitoring_role_arn                   = aws_iam_role.tf_iam_role_rds.arn
  preferred_maintenance_window          = var.maintenance_window
  monitoring_interval                   = var.monitoring_interval
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade

  apply_immediately = var.apply_immediately

  tags = {
    Name = "${var.project}-${var.environment}-rds-instance-1a"
  }
}


# ====================
#
# RDS Subnet Group
#
# ====================
resource "aws_db_subnet_group" "tf_db_subnet_group" {
  name = "${var.project}-${var.environment}-rds-subnet-group"
  subnet_ids = [
    aws_subnet.tf_subnet_5.id,
    aws_subnet.tf_subnet_6.id
  ]
}
