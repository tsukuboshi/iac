# ====================
#
# Output
#
# ====================

output "lb_dns_name" {
  value       = aws_lb.example_alb.dns_name
  description = "ALBのDNS名"
}
