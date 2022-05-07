# ====================
#
# SSM Parameter Store
#
# ====================

resource "aws_ssm_parameter" "tf_rds_db_name" {
  name  = "/${var.project}/${var.environment}/DB_NAME"
  type  = "SecureString"
  value = var.db_name
}

resource "aws_ssm_parameter" "tf_rds_root_name" {
  name  = "/${var.project}/${var.environment}/DB_ROOT_NAME"
  type  = "SecureString"
  value = var.db_root_name
}

resource "aws_ssm_parameter" "tf_rds_root_pass" {
  name  = "/${var.project}/${var.environment}/DB_ROOT_PASS"
  type  = "SecureString"
  value = var.db_root_pass
}

resource "aws_ssm_parameter" "tf_rds_user_name" {
  name  = "/${var.project}/${var.environment}/DB_USER_NAME"
  type  = "SecureString"
  value = var.db_user_name
}

resource "aws_ssm_parameter" "tf_rds_user_pass" {
  name  = "/${var.project}/${var.environment}/DB_USER_PASS"
  type  = "SecureString"
  value = var.db_user_pass
}
