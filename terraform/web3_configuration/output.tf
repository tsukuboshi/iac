# ====================
#
# Output
#
# ====================

output "domain_name" {
  value = aws_route53_record.example_route53_record.name
}

output "rds_endpoint" {
	value = aws_db_instance.example_db.endpoint
}

output "db_password" {
  value = var.db_password
}
