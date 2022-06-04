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

# インバウンドルール(https接続用)
resource "aws_security_group_rule" "tf_in_http_alb" {
  security_group_id = aws_security_group.tf_sg_alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
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

# ElastiCache用セキュリティグループ
resource "aws_security_group" "tf_sg_elasticache" {
  name   = "${var.project}-${var.environment}-elasticache-sg"
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-elasticache-sg"
  }

  depends_on = [aws_security_group.tf_sg_ec2]
}

# インバウンドルール(redis接続用)
resource "aws_security_group_rule" "tf_in_redis_elasticache" {
  security_group_id        = aws_security_group.tf_sg_elasticache.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 6379
  to_port                  = 6379
  source_security_group_id = aws_security_group.tf_sg_ec2.id
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "tf_out_all_elasticache" {
  security_group_id = aws_security_group.tf_sg_elasticache.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
