# ====================
#
# Output
#
# ====================

output "domain_name" {
  value = aws_route53_record.example_route53_record.name
}

output "instance_1a_private_ip" {
  value = aws_instance.example_instance_1a.private_ip
}

output "instance_1c_private_ip" {
  value = aws_instance.example_instance_1c.private_ip
}

output "rds_endpoint" {
  value = aws_db_instance.example_db.endpoint
}

output "db_password" {
  value = var.db_password
}
