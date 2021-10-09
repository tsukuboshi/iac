# ====================
#
# Output
#
# ====================

output "domain_name" {
  value = aws_route53_record.example_route53_record.name
}
