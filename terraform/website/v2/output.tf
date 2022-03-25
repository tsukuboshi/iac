# ====================
#
# Output
#
# ====================

output "alb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}

output "instance_1a_id" {
  value = aws_instance.tf_instance_1a.id
}

output "instance_1d_id" {
  value = aws_instance.tf_instance_1c.id
}

output "rds_endpoint" {
  value = aws_db_instance.tf_db.endpoint
}

output "db_password" {
  value = var.db_password
}
