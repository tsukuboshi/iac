# ====================
#
# Security Group
#
# ====================

# ALB用セキュリティグループ
resource "aws_security_group" "example_sg_alb" {
  name   = "example_sg_alb"
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg-alb"
    Project = var.project
    Env     = var.environment
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "in_http_alb" {
  security_group_id = aws_security_group.example_sg_alb.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

# インバウンドルール(https接続用)
resource "aws_security_group_rule" "in_https_alb" {
  security_group_id = aws_security_group.example_sg_alb.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all_alb" {
  security_group_id = aws_security_group.example_sg_alb.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# ECS用セキュリティグループ
resource "aws_security_group" "example_sg_ecs" {
  name   = "example_sg_ecs"
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg-ecs"
    Project = var.project
    Env     = var.environment
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "in_http_ecs" {
  security_group_id = aws_security_group.example_sg_ecs.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

# インバウンドルール(https接続用)
resource "aws_security_group_rule" "in_https_ecs" {
  security_group_id = aws_security_group.example_sg_ecs.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all_ecs" {
  security_group_id = aws_security_group.example_sg_ecs.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
