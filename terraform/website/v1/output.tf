# ====================
#
# Output
#
# ====================

output "instance_1a_id" {
  value = aws_instance.tf_instance_1a.id
}

output "instance_1c_id" {
  value = aws_instance.tf_instance_1c.id
}

output "alb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}

output "url_for_access" {
  value = "http://${aws_lb.tf_alb.dns_name}"
}

output "rds_endpoint" {
  value = aws_db_instance.tf_db_instance.address
}
