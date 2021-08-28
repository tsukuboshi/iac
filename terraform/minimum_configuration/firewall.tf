# ====================
#
# Security Group
#
# ====================
resource "aws_security_group" "test_sg" {
  name   = "test_sg"
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg"
    Project = var.project
    Env     = var.environment
  }
}

# インバウンドルール(ssh接続用)
resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.test_sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

# インバウンドルール(ping疎通確認用)
resource "aws_security_group_rule" "in_icmp" {
  security_group_id = aws_security_group.test_sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.test_sg.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
