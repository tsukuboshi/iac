# ====================
#
# Outputs
#
# ====================

output "acm_alb_cert_arn" {
  value = aws_acm_certificate.tf_acm_alb_cert.arn
}

output "acm_alb_cert_valid_id" {
  value = aws_acm_certificate_validation.tf_acm_alb_cert_valid.id
}
