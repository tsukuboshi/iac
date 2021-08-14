# ====================
#
# ALB
#
# ====================
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false             #falseを指定するとインターネット向け,trueを指定すると内部向け
  load_balancer_type = "application"

  security_groups    = [
    aws_security_group.web_sg_alb.id
  ]

  subnets            = [
      aws_subnet.web_subnet_alb_1a.id,
      aws_subnet.web_subnet_alb_1c.id,
  ]
}

# ====================
#
# Listener
#
# ====================

resource "aws_lb_listener" "web_alb_lsnr" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "http"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

}

resource "aws_lb_listener_rule" "forward" {
  listener_arn = aws_lb_listener.web_alb_lsnr.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

  condition {
      path_pattern{
        values = ["/*"]
      }
  }
}

# ====================
#
# Target Group
#
# ====================

resource "aws_lb_target_group" "web_alb_tg" {
  port        = 80
  protocol    = "http"
  vpc_id      = aws_vpc.web_vpc.id

  health_check {
        path        = "/index.html"
  }
}

resource "aws_lb_target_group_attachment" "web_alb_tgec2_1a" {
  target_group_arn = aws_lb_target_group.web_alb_tg.arn
  target_id        = aws_instance.web_instance_1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_alb_tgec2_1c" {
  target_group_arn = aws_lb_target_group.web_alb_tg.arn
  target_id        = aws_instance.web_instance_1c.id
  port             = 80
}
