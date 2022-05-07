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

output "url_for_static_content" {
  value = "https://${aws_route53_record.tf_route53_record_view_cf_access.name}/static/index.html"
}

output "url_for_view" {
  value = "https://${aws_route53_record.tf_route53_record_view_cf_access.name}"
}

# output "rds_endpoint" {
#   value = aws_rds_cluster.tf_rds_cluster.endpoint
# }
