# ====================
#
# Route53
#
# ====================

data "aws_route53_zone" "example_route53_zone" {
  name = var.domain
}
resource "aws_route53_record" "example_route53_record" {
  zone_id = data.aws_route53_zone.example_route53_zone.id
  name    = "www.example.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_lb.example_alb.dns_name
    zone_id                = aws_lb.example_alb.zone_id
    evaluate_target_health = true
  }
}
