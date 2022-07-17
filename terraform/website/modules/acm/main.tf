# ====================
#
# ACM Certificate
#
# ====================

data "aws_route53_zone" "tf_route53_zone" {
  name = var.route53_zone_name
}

resource "aws_acm_certificate" "tf_acm_alb_cert" {
  domain_name               = var.acm_domain_name
  subject_alternative_names = [var.acm_sans]
  validation_method         = "DNS"

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-alb-acm"
  }

  lifecycle {
    create_before_destroy = true
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

resource "aws_route53_record" "tf_route53_record_acm_alb_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.tf_acm_alb_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 600
  type            = each.value.type
  zone_id         = data.aws_route53_zone.tf_route53_zone.zone_id
}

resource "aws_acm_certificate_validation" "tf_acm_alb_cert_valid" {
  certificate_arn         = aws_acm_certificate.tf_acm_alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.tf_route53_record_acm_alb_dns_resolve : record.fqdn]
}
