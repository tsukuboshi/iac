# ====================
#
# RDS instance
#
# ====================

resource "aws_db_instance" "tf_db_instance" {
  engine         = "mysql"
  engine_version = var.rds_engine_version

  identifier = "${var.system}-${var.project}-${var.environment}-db-instance"

  db_subnet_group_name   = aws_db_subnet_group.tf_db_subnetgroup.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false
  port                   = 3306

  parameter_group_name = aws_db_parameter_group.tf_db_parametergroup.name
  option_group_name    = aws_db_option_group.tf_db_optiongroup.name

  instance_class = var.db_instance_class
  multi_az       = var.internal == true ? false : true

  db_name  = var.db_name
  username = var.db_root_name
  password = var.db_root_pass

  storage_type          = var.db_storage_type
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_encrypted     = var.db_storage_encrypted

  enabled_cloudwatch_logs_exports = var.db_enabled_cloudwatch_logs_exports

  backup_retention_period = var.db_backup_retention_period
  backup_window           = var.db_backup_window
  maintenance_window      = var.db_maintenance_window

  performance_insights_enabled          = var.db_performance_insights_enabled
  performance_insights_retention_period = var.db_performance_insights_retention_period
  monitoring_role_arn                   = var.db_monitoring_role_arn
  monitoring_interval                   = var.db_monitoring_interval

  auto_minor_version_upgrade = var.db_auto_minor_version_upgrade

  deletion_protection = var.internal == true ? false : true
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-db-instance"
  }
}

# ====================
#
# RDS Subnet Group
#
# ====================
resource "aws_db_subnet_group" "tf_db_subnetgroup" {
  name = "${var.system}-${var.project}-${var.environment}-db-subnetgroup"
  subnet_ids = [
    var.isolated_1a_subnet_id,
    var.isolated_1c_subnet_id
  ]

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-db-subnetgroup"
  }
}


# ====================
#
# RDS Parameter Group
#
# ====================
resource "aws_db_parameter_group" "tf_db_parametergroup" {
  name   = "${var.system}-${var.project}-${var.environment}-db-parametergroup"
  family = "mysql8.0"
}


# ====================
#
# RDS Option Group
#
# ====================

resource "aws_db_option_group" "tf_db_optiongroup" {
  name                 = "${var.system}-${var.project}-${var.environment}-db-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}
