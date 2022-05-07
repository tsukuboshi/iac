# ====================
#
# Security Group
#
# ====================

# ALB用セキュリティグループ
resource "aws_security_group" "tf_sg_alb" {
  name   = "${var.project}-${var.environment}-alb-web-sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-alb-web-sg"
  }
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "tf_in_http_alb" {
  security_group_id = aws_security_group.tf_sg_alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_alb" {
  security_group_id = aws_security_group.tf_sg_alb.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# EC2用セキュリティグループ
resource "aws_security_group" "tf_sg_ec2" {
  name   = "${var.project}-${var.environment}-ec2-web-sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-ec2-web-sg"
  }

  depends_on = [aws_security_group.tf_sg_alb]
}

# インバウンドルール(http接続用)
resource "aws_security_group_rule" "tf_in_http_ec2" {
  security_group_id        = aws_security_group.tf_sg_ec2.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.tf_sg_alb.id
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_ec2" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# EFS用セキュリティグループ
resource "aws_security_group" "tf_sg_efs" {
  name   = "${var.project}-${var.environment}-efs-sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-efs-sg"
  }

  depends_on = [aws_security_group.tf_sg_ec2]
}

# インバウンドルール(efs接続用)
resource "aws_security_group_rule" "tf_in_efs" {
  security_group_id        = aws_security_group.tf_sg_efs.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
  source_security_group_id = aws_security_group.tf_sg_ec2.id
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_efs" {
  security_group_id = aws_security_group.tf_sg_efs.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# RDS用セキュリティグループ
resource "aws_security_group" "tf_sg_rds" {
  name   = "${var.project}-${var.environment}-rds-sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-rds-sg"
  }

  depends_on = [aws_security_group.tf_sg_ec2]
}

# インバウンドルール(mysql接続用)
resource "aws_security_group_rule" "tf_in_mysql_rds" {
  security_group_id        = aws_security_group.tf_sg_rds.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.tf_sg_ec2.id
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_rds" {
  security_group_id = aws_security_group.tf_sg_rds.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
