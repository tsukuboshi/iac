# ====================
#
# AMI
#
# ====================
# 最新版のAmazonLinux2のAMI情報
data "aws_ami" "test_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ====================
#
# EC2 Instance
#
# ====================

resource "aws_instance" "test_instance" {
  ami                    = data.aws_ami.test_ami.image_id
  key_name               = aws_key_pair.test_key.id
  subnet_id              = aws_subnet.test_subnet.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  instance_type          = var.instance_type
  root_block_device {
    volume_type          = var.volume_type
    volume_size          = var.volume_size
  }
  user_data              = var.user_data
}

# ====================
#
# Key Pair
#
# ====================

resource "aws_key_pair" "test_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support   = true # DNS解決有効化
  enable_dns_hostnames = true # DNSホスト名有効化

  tags = {
    Name = "my-vpc"
  }
}

# ====================
#
# Subnet
#
# ====================

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.subnet_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化

  tags = {
    Name = "my-subnet"
  }
}

# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "test_gw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "my-gw"
  }
}

# ====================
#
# Route Table
#
# ====================
resource "aws_route_table" "test_rt" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route" "test_route" {
  route_table_id         = aws_route_table.test_rt.id
  gateway_id             = aws_internet_gateway.test_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "test_subrt" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_rt.id
}

# ====================
#
# Security Group
#
# ====================
resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  vpc_id      = aws_vpc.test_vpc.id

  tags = {
    Name = "test_sg"
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
