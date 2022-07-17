# ====================
#
# RDS Cluster
#
# ====================
resource "aws_rds_cluster" "tf_rds_cluster" {
  engine         = "aurora-mysql"
  engine_version = var.aurora_engine_version

  cluster_identifier = "${var.system}-${var.project}-${var.environment}-rds-cluster"

  db_subnet_group_name   = aws_db_subnet_group.tf_db_subnet_group.name
  vpc_security_group_ids = [var.security_group_id]
  port                   = 3306

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.tf_rds_cluster_parameter_group.name

  database_name   = var.db_name
  master_username = var.db_root_name
  master_password = var.db_root_pass

  storage_encrypted = var.db_storage_encrypted

  enabled_cloudwatch_logs_exports = var.db_enabled_cloudwatch_logs_exports

  backup_retention_period      = var.db_backup_retention_period
  preferred_backup_window      = var.db_backup_window
  preferred_maintenance_window = var.db_maintenance_window

  deletion_protection = var.internal == true ? false : true
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-cluster"
  }
}

# ====================
#
# RDS Instance
#
# ====================
resource "aws_rds_cluster_instance" "tf_rds_cluster_instance" {
  engine         = aws_rds_cluster.tf_rds_cluster.engine
  engine_version = aws_rds_cluster.tf_rds_cluster.engine_version

  cluster_identifier = aws_rds_cluster.tf_rds_cluster.id
  identifier         = "${var.system}-${var.project}-${var.environment}-rds-instance"

  publicly_accessible = false

  db_parameter_group_name = aws_db_parameter_group.tf_db_parameter_group.name

  count          = var.internal == true ? 1 : 2
  instance_class = var.db_instance_class

  performance_insights_enabled          = var.db_performance_insights_enabled
  performance_insights_retention_period = var.db_performance_insights_retention_period
  monitoring_interval                   = var.db_monitoring_interval
  monitoring_role_arn                   = var.db_monitoring_role_arn

  auto_minor_version_upgrade = var.db_auto_minor_version_upgrade

  apply_immediately = true

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-instance"
  }
}


# ====================
#
# RDS Subnet Group
#
# ====================
resource "aws_db_subnet_group" "tf_db_subnet_group" {
  name = "${var.system}-${var.project}-${var.environment}-rds-subnet-group"
  subnet_ids = [
    var.isolated_1a_subnet_id,
    var.isolated_1c_subnet_id
  ]

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-subnetgroup"
  }
}

# ====================
#
# RDS Parameter Group
#
# ====================
resource "aws_rds_cluster_parameter_group" "tf_rds_cluster_parameter_group" {
  name   = "${var.system}-${var.project}-${var.environment}-rds-cluster-parametergroup"
  family = "aurora-mysql8.0"

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-cluster-parametergroup"
  }
}

resource "aws_db_parameter_group" "tf_db_parameter_group" {
  name   = "${var.system}-${var.project}-${var.environment}-rds-parametergroup"
  family = "aurora-mysql8.0"

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-rds-parametergroup"
  }
}
