# ====================
#
# RDS Parameter Group
#
# ====================
resource "aws_db_parameter_group" "tf_db_parametergroup" {
  name   = "${var.project}-${var.environment}-db-parametergroup"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
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
# RDS instance
#
# ====================

resource "aws_db_instance" "tf_db" {
  engine         = "mysql"
  engine_version = "8.0.20"

  identifier = "${var.project}-${var.environment}-db"

  username = "root"
  password = var.db_password

  instance_class = var.instance_class

  storage_type          = var.storage_type
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = false

  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.tf_db_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.tf_sg_rds.id]
  publicly_accessible    = false
  port                   = 3306

  db_name              = "${var.project}${var.environment}db"
  parameter_group_name = aws_db_parameter_group.tf_db_parametergroup.name
  option_group_name    = aws_db_option_group.tf_db_optiongroup.name

  backup_window              = var.backup_window
  backup_retention_period    = var.backup_retention_period
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = false

  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name    = "${var.project}-${var.environment}-db"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# SSM Parameters Store
#
# ====================

resource "aws_ssm_parameter" "sp_db_name" {
  name  = "/${var.project}/${var.environment}/website/MYSQL_DATABASE"
  type  = "String"
  value = aws_db_instance.tf_db.db_name
}

resource "aws_ssm_parameter" "sp_db_user" {
  name  = "/${var.project}/${var.environment}/website/MYSQL_USERNAME"
  type  = "SecureString"
  value = aws_db_instance.tf_db.username
}

resource "aws_ssm_parameter" "sp_db_password" {
  name  = "/${var.project}/${var.environment}/website/MYSQL_PASSWORD"
  type  = "SecureString"
  value = aws_db_instance.tf_db.password
}
