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

output "domain_url" {
  value = "https://${data.aws_route53_zone.tf_route53_zone.name}"
}

output "rds_endpoint" {
  value = aws_rds_cluster.tf_rds_cluster.endpoint
}
