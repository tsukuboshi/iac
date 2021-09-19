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
  port              = "80"
  protocol          = "HTTP"

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
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.example_vpc.id
  deregistration_delay = var.deregistration_delay

  health_check {
    path = "/index.html"
  }

  tags = {
    Name    = "${var.project}-${var.environment}-alp-tg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_lb_target_group_attachment" "example_alb_tgec2_1a" {
  target_group_arn = aws_lb_target_group.example_alb_tg.arn
  target_id        = aws_instance.example_instance_1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "example_alb_tgec2_1c" {
  target_group_arn = aws_lb_target_group.example_alb_tg.arn
  target_id        = aws_instance.example_instance_1c.id
  port             = 80
}
