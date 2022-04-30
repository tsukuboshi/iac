# ====================
#
# Route53
#
# ====================

data "aws_route53_zone" "tf_route53_zone" {
  name = var.registered_domain
}

#ALBへのSSL通信用Aレコード
resource "aws_route53_record" "tf_route53_record_alb_access" {
  zone_id = data.aws_route53_zone.tf_route53_zone.id
  name    = data.aws_route53_zone.tf_route53_zone.name
  type    = "A"

  alias {
    name                   = aws_lb.tf_alb.dns_name
    zone_id                = aws_lb.tf_alb.zone_id
    evaluate_target_health = true
  }
}

#ACM検証用CNAMEレコード
resource "aws_route53_record" "tf_route53_record_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.tf_acm_cert.domain_validation_options : dvo.domain_name => {
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
