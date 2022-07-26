# ====================
#
# Target Group
#
# ====================

resource "aws_lb_target_group" "tf_alb_tg" {
  name                          = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-tg"
  target_type                   = var.alb_target_type
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  deregistration_delay          = 300
  slow_start                    = 0
  load_balancing_algorithm_type = "round_robin"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-tg"
  }
}

# ====================
#
# Listener Rule
#
# ====================


resource "aws_lb_listener_rule" "tf_alb_lsnr_rule" {
  listener_arn = var.alb_lsnr_https_arn
  priority     = var.alb_lsnr_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_alb_tg.arn
  }

  dynamic "condition" {
    for_each = var.has_host_header ? { dummy : "hoge" } : {}
    content {
      host_header {
        values = [var.alb_lsnr_rule_host_header]
      }
    }
  }

  dynamic "condition" {
    for_each = var.has_path_pattern ? { dummy : "hoge" } : {}
    content {
      path_pattern {
        values = [var.alb_lsnr_rule_path_pattern]
      }
    }
  }
}
