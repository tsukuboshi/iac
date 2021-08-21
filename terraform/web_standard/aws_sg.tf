# ====================
#
# Security Group
#
# ====================

# ALB用セキュリティグループ
resource "aws_security_group" "web_sg_alb" {
  name   = "web_sg_alb"
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_sg_alb"
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "in_http_alb" {
  security_group_id = aws_security_group.web_sg_alb.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all_alb" {
  security_group_id = aws_security_group.web_sg_alb.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# EC2用セキュリティグループ
resource "aws_security_group" "web_sg_ec2" {
  name   = "web_sg_ec2"
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_sg_ec2"
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "in_http_ec2" {
  security_group_id = aws_security_group.web_sg_ec2.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all_ec2" {
  security_group_id = aws_security_group.web_sg_ec2.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# RDS用セキュリティグループ
resource "aws_security_group" "web_sg_rds" {
  name   = "web_sg_rds"
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_sg_alb"
  }
}

# インバウンドルール(mysql接続用)
resource "aws_security_group_rule" "in_mysql_rds" {
  security_group_id = aws_security_group.web_sg_rds.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all_rds" {
  security_group_id = aws_security_group.web_sg_rds.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
