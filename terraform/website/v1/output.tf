# ====================
#
# Output
#
# ====================

output "alb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}

output "instance_1a_public_ip" {
  value = aws_instance.tf_instance_1a.public_ip
}

output "instance_1c_public_ip" {
  value = aws_instance.tf_instance_1c.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.tf_db.endpoint
}

output "db_password" {
  value = var.db_password
}
