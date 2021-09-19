# ====================
#
# Output
#
# ====================

output "lb_dns_name" {
  value = aws_lb.example_alb.dns_name
}

output "domain_name" {
  value       = aws_route53_record.example_route53_record.name
  description = "Before accessing the domain, check if the NS record of the created hosted zone to the name server of the registered domain."
}
