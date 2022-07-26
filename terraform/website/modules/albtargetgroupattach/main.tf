# ====================
#
# Target Group Attatchment
#
# ====================

resource "aws_lb_target_group_attachment" "tf_alb_tgec2" {
  target_group_arn = var.target_group_arn
  target_id        = var.instance_id
}
