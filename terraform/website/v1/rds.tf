# ====================
#
# RDS instance
#
# ====================

resource "aws_db_instance" "tf_db_instance" {
  engine         = "mysql"
  engine_version = "8.0.20"

  identifier             = "${var.project}-${var.environment}-db"

  db_subnet_group_name   = aws_db_subnet_group.tf_db_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.tf_sg_rds.id]
  publicly_accessible    = false
  port                   = 3306

  parameter_group_name = aws_db_parameter_group.tf_db_parametergroup.name
  option_group_name    = aws_db_option_group.tf_db_optiongroup.name

  instance_class                        = var.instance_class
  multi_az                              = var.multi_az

  db_name                = "${var.project}${var.environment}db"
  username                              = var.db_root_name
  password                              = var.db_root_pass

  storage_type                          = var.storage_type
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage

  storage_encrypted                     = var.storage_encrypted

  backup_retention_period               = var.backup_retention_period
  backup_window                         = var.backup_window
  maintenance_window                    = var.maintenance_window

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = aws_iam_role.tf_iam_role_rds.arn

  deletion_protection                   = var.deletion_protection

  auto_minor_version_upgrade            = var.auto_minor_version_upgrade

  skip_final_snapshot                   = var.skip_final_snapshot
  apply_immediately                     = var.apply_immediately

  tags = {
    Name    = "${var.project}-${var.environment}-db"
  }
}

# ====================
#
# RDS Subnet Group
#
# ====================
resource "aws_db_subnet_group" "tf_db_subnetgroup" {
  name = "${var.project}-${var.environment}-db-subnetgroup"
  subnet_ids = [
    aws_subnet.tf_subnet_3.id,
    aws_subnet.tf_subnet_4.id
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-db-subnetgroup"
    Project = var.project
    Env     = var.environment
  }
}


# ====================
#
# RDS Parameter Group
#
# ====================
resource "aws_db_parameter_group" "tf_db_parametergroup" {
  name   = "${var.project}-${var.environment}-db-parametergroup"
  family = "mysql8.0"
}


# ====================
#
# RDS Option Group
#
# ====================

resource "aws_db_option_group" "tf_db_optiongroup" {
  name                 = "${var.project}-${var.environment}-db-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}
