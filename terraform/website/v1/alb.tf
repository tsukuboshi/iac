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

  enable_deletion_protection = var.enable_deletion_protection
}

# ====================
#
# Listener
#
# ====================

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.tf_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_alb_tg.arn
  }
}

# ====================
#
# Target Group
#
# ====================

resource "aws_lb_target_group" "tf_alb_tg" {
  name                          = "${var.project}-${var.environment}-web-tg"
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
