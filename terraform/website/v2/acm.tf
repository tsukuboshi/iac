# ====================
#
# ACM Certificate
#
# ====================
resource "aws_acm_certificate" "tf_acm_cert" {
  domain_name               = var.registered_domain
  subject_alternative_names = ["*.${var.registered_domain}"]
  validation_method         = "DNS"

  tags = {
    Name = "${var.project}-${var.environment}-acm-alb"
  }

  depends_on = [
    data.aws_route53_zone.tf_route53_zone
  ]
}

# ====================
#
# ACM DNS Verifycation
#
# ====================
resource "aws_acm_certificate_validation" "tf_acm_cert_valid" {
  certificate_arn         = aws_acm_certificate.tf_acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.tf_route53_record_acm_dns_resolve : record.fqdn]
}
