# ====================
#
# ALB
#
# ====================
resource "aws_lb" "example_alb" {
  name                       = "${var.project}-${var.environment}-app-alb"
  internal                   = false #falseを指定するとインターネット向け,trueを指定すると内部向け
  load_balancer_type         = "application"
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.example_log_bucket.id
    enabled = true
  }

  subnets = [
    aws_subnet.example_subnet_1.id,
    aws_subnet.example_subnet_2.id,
  ]

  security_groups = [
    aws_security_group.example_sg_alb.id
  ]
}

# ====================
#
# Listener
#
# ====================

resource "aws_lb_listener" "example_alb_lsnr_http" {
  load_balancer_arn = aws_lb.example_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "example_alb_lsnr_https" {
  load_balancer_arn = aws_lb.example_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.example_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_alb_tg.arn
  }
}


# ====================
#
# Target Group
#
# ====================

resource "aws_lb_target_group" "example_alb_tg" {
  name                 = "${var.project}-${var.environment}-alp-tg"
  target_type          = "instance"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.example_vpc.id
  deregistration_delay = var.deregistration_delay

  health_check {
    path                = "/"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    matcher             = var.matcher
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [
    aws_lb.example_alb
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-alp-tg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_lb_target_group_attachment" "example_alb_tgec2_1a" {
  target_group_arn = aws_lb_target_group.example_alb_tg.arn
  target_id        = aws_instance.example_instance_1a.id
}

resource "aws_lb_target_group_attachment" "example_alb_tgec2_1c" {
  target_group_arn = aws_lb_target_group.example_alb_tg.arn
  target_id        = aws_instance.example_instance_1c.id
}

data "aws_elb_service_account" "example_log_service_account" {}
