# ====================
#
# Output
#
# ====================

output "alb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.tf_db.endpoint
}

output "db_password" {
  value = var.db_password
}
