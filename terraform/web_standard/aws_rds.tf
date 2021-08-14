# ====================
#
# RDS
#
# ====================
resource "aws_db_instance" "web_db" {
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  storage_type           = var.db_storage_type
  name                   = "web_db"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.db_parameter_group_name
  multi_az               = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.web_subnet_db_group.name
  vpc_security_group_ids = [aws_security_group.web_sg_rds.id]
}
