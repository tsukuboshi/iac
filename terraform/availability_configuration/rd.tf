# ====================
#
# RDS Parameter Group
#
# ====================
resource "aws_db_parameter_group" "example_db_parametergroup" {
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

resource "aws_db_option_group" "example_db_optiongroup" {
  name                 = "${var.project}-${var.environment}-db-optiongroup"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}


# ====================
#
# RDS Subnet Group
#
# ====================
resource "aws_db_subnet_group" "example_db_subnetgroup" {
  name = "${var.project}-${var.environment}-db-subnetgroup"
  subnet_ids = [
    aws_subnet.example_subnet_5.id,
    aws_subnet.example_subnet_6.id
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

resource "aws_db_instance" "example_db" {
  engine         = "mysql"
  engine_version = "8.0.20"

  identifier = "${var.project}-${var.environment}-db"

  username = "admin"
  password = var.db_password

  instance_class = var.instance_class

  storage_type          = var.storage_type
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = false

  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.example_db_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.example_sg_rds.id]
  publicly_accessible    = false
  port                   = 3306

  name                 = "${var.project}-${var.environment}-db"
  parameter_group_name = aws_db_parameter_group.example_db_parametergroup.name
  option_group_name    = aws_db_option_group.example_db_optiongroup.name

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
