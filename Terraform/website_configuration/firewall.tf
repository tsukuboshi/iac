# ====================
#
# Security Group
#
# ====================

# ALB用セキュリティグループ
resource "aws_security_group" "tf_sg_alb" {
  name   = "tf_sg_alb"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg-alb"
    Project = var.project
    Env     = var.environment
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "tf_in_http_alb" {
  security_group_id = aws_security_group.tf_sg_alb.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_alb" {
  security_group_id = aws_security_group.tf_sg_alb.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# EC2用セキュリティグループ
resource "aws_security_group" "tf_sg_ec2" {
  name   = "tf_sg_ec2"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg-ec2"
    Project = var.project
    Env     = var.environment
  }

  depends_on = [aws_security_group.tf_sg_alb]
}

# インバウンドルール(ssh接続用)
resource "aws_security_group_rule" "tf_in_ssh_ec2" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "tf_in_http_ec2" {
  security_group_id        = aws_security_group.tf_sg_ec2.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.tf_sg_alb.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_ec2" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# RDS用セキュリティグループ
resource "aws_security_group" "tf_sg_rds" {
  name   = "tf_sg_rds"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-sg-rds"
    Project = var.project
    Env     = var.environment
  }

  depends_on = [aws_security_group.tf_sg_ec2]
}

# インバウンドルール(mysql接続用)
resource "aws_security_group_rule" "tf_in_mysql_rds" {
  security_group_id        = aws_security_group.tf_sg_rds.id
  type                     = "ingress"
  source_security_group_id = aws_security_group.tf_sg_ec2.id
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_rds" {
  security_group_id = aws_security_group.tf_sg_rds.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
