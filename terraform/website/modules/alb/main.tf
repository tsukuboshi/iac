# ====================
#
# Load Balancer
#
# ====================
resource "aws_lb" "tf_alb" {
  name               = "${var.system}-${var.project}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    var.subnet_1a_id,
    var.subnet_1c_id,
  ]

  security_groups = [
    var.security_group_id
  ]

  dynamic "access_logs" {
    for_each = var.has_access_logs ? { dummy : "hoge" } : {}
    content {
      bucket  = var.access_log_bucket_name
      prefix  = var.access_log_prefix
      enabled = true
    }
  }

  enable_deletion_protection = var.internal == true ? false : true
  idle_timeout               = 60
  enable_http2               = true

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-alb"
  }
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
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-alb-lsnr-http"
  }
}

resource "aws_lb_listener" "tf_alb_lsnr_https" {
  load_balancer_arn = aws_lb.tf_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_alb_cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-alb-lsnr-https"
  }

  depends_on = [
    var.acm_alb_cert_valid_id
  ]
}
