# ====================
#
# ACM Certificate
#
# ====================
resource "aws_acm_certificate" "tf_acm_alb_cert" {
  domain_name               = var.naked_domain
  subject_alternative_names = ["*.${var.naked_domain}"]
  validation_method         = "DNS"

  tags = {
    Name = "${var.project}-${var.environment}-acm-alb"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    data.aws_route53_zone.tf_route53_zone
  ]
}

resource "aws_acm_certificate" "tf_acm_cf_cert" {
  domain_name       = var.naked_domain
  validation_method = "DNS"
  provider          = aws.virginia

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.project}-${var.environment}-acm-cf"
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
resource "aws_acm_certificate_validation" "tf_acm_alb_cert_valid" {
  certificate_arn         = aws_acm_certificate.tf_acm_alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.tf_route53_record_acm_alb_dns_resolve : record.fqdn]
}

resource "aws_acm_certificate_validation" "tf_acm_cf_cert_valid" {
  certificate_arn         = aws_acm_certificate.tf_acm_cf_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.tf_route53_record_acm_cf_dns_resolve : record.fqdn]
  provider                = aws.virginia
}
