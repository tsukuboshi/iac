# ====================
#
# Route53 Record
#
# ====================

data "aws_route53_zone" "tf_route53_zone" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "tf_route53_record_alb_access" {
  zone_id = data.aws_route53_zone.tf_route53_zone.id
  name    = var.route53_record_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
