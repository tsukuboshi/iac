# ====================
#
# ALB
#
# ====================
resource "aws_lb" "tf_alb" {
  name                       = "${var.project}-${var.environment}-app-alb"
  internal                   = false #falseを指定するとインターネット向け,trueを指定すると内部向け
  load_balancer_type         = "application"
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = false

  subnets = [
    aws_subnet.tf_subnet_1.id,
    aws_subnet.tf_subnet_2.id,
  ]

  security_groups = [
    aws_security_group.tf_sg_alb.id
  ]
}

# ====================
#
# Listener
#
# ====================

resource "aws_lb_listener" "tf_alb_lsnr_http" {
  load_balancer_arn = aws_lb.tf_alb.arn
  port              = 80
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
  name                 = "${var.project}-${var.environment}-alp-tg"
  target_type          = "instance"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.tf_vpc.id
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
    aws_lb.tf_alb
  ]

  tags = {
    Name    = "${var.project}-${var.environment}-alp-tg"
    Project = var.project
    Env     = var.environment
  }
}

data "aws_elb_service_account" "tf_log_service_account" {}
