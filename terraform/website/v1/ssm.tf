
# ====================
#
# SSM Parameter Store
#
# ====================

resource "aws_ssm_parameter" "tf_rds_master_username" {
  name  = "/${var.project}/${var.environment}/app/MYSQL_USERNAME"
  type  = "SecureString"
  value = aws_rds_cluster.tf_rds_cluster.master_username
}

resource "aws_ssm_parameter" "tf_rds_master_password" {
  name  = "/${var.project}/${var.environment}/app/MYSQL_PASSWORD"
  type  = "SecureString"
  value = aws_rds_cluster.tf_rds_cluster.master_password
}
