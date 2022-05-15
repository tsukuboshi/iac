# ====================
#
# Load Balancer
#
# ====================
resource "aws_lb" "tf_alb" {
  name               = "${var.project}-${var.environment}-web-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.tf_subnet_1.id,
    aws_subnet.tf_subnet_2.id,
  ]

  security_groups = [
    aws_security_group.tf_sg_alb.id
  ]

  access_logs {
    bucket  = aws_s3_bucket.tf_bucket_alb_log.bucket
    prefix  = var.alb_log_prefix
    enabled = true
  }

  enable_deletion_protection = var.enable_deletion_protection
}

# ====================
#
# Listener
#
# ====================

resource "aws_lb_listener" "tf_alb_lsnr_https" {
  load_balancer_arn = aws_lb.tf_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.tf_acm_alb_cert.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }

  depends_on = [
    aws_acm_certificate_validation.tf_acm_alb_cert_valid
  ]
}

resource "aws_lb_listener_rule" "tf_alb_listener_rule_access" {
  listener_arn = aws_lb_listener.tf_alb_lsnr_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_alb_tg.arn
  }

  condition {
    http_header {
      http_header_name = var.custom_header_name
      values           = [var.custom_header_value]
    }
  }
}

# ====================
#
# Target Group
#
# ====================

resource "aws_lb_target_group" "tf_alb_tg" {
  name                          = "${var.project}-${var.environment}-web-tg-${substr(uuid(), 0, 6)}"
  target_type                   = "instance"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.tf_vpc.id
  deregistration_delay          = var.deregistration_delay
  slow_start                    = var.slow_start
  load_balancing_algorithm_type = var.load_balancing_algorithm_type

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    matcher             = var.matcher
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

resource "aws_lb_target_group_attachment" "tf_alb_tgec2_1a" {
  target_group_arn = aws_lb_target_group.tf_alb_tg.arn
  target_id        = aws_instance.tf_instance_1a.id
}

resource "aws_lb_target_group_attachment" "tf_alb_tgec2_1c" {
  target_group_arn = aws_lb_target_group.tf_alb_tg.arn
  target_id        = aws_instance.tf_instance_1c.id
}

data "aws_elb_service_account" "tf_log_service_account" {}
