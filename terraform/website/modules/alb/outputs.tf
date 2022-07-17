# ====================
#
# Outputs
#
# ====================

output "alb_lsnr_https_arn" {
  value = aws_lb_listener.tf_alb_lsnr_https.arn
}

output "alb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.tf_alb.zone_id
}
