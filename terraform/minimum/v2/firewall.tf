# ====================
#
# Security Group
#
# ====================
resource "aws_security_group" "tf_sg" {
  name   = "tf_sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg"
    Project = var.project
    Env     = var.environment
  }
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.tf_sg.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
