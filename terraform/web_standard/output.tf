# ====================
#
# Output
#
# ====================

output "web_alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "ALBのDNS名"
}
