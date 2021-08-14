# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "web_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support   = true # DNS解決有効化
  enable_dns_hostnames = true # DNSホスト名有効化

  tags = {
    Name = "web_vpc"
  }
}

# ====================
#
# Public Subnet
#
# ====================

resource "aws_subnet" "web_subnet_alb_1a" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_alb_1a_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "web_subnet_alb_1a"
  }
}

resource "aws_subnet" "web_subnet_alb_1c" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_alb_1c_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "web_subnet_alb_1c"
  }
}

resource "aws_subnet" "web_subnet_ec2_1a" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_ec2_1a_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "web_subnet_ec2_1a"
  }
}

resource "aws_subnet" "web_subnet_ec2_1c" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_ec2_1c_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "web_subnet_ec2_1c"
  }
}



# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "web_gw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_gw"
  }
}

# ====================
#
# Route Table
#
# ====================
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    Name = "web_route_table"
  }
}

resource "aws_route" "web_route" {
  route_table_id         = aws_route_table.web_rt.id
  gateway_id             = aws_internet_gateway.web_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "web_subrt_alb_1a" {
  subnet_id      = aws_subnet.web_subnet_alb_1a.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_subrt_alb_1c" {
  subnet_id      = aws_subnet.web_subnet_alb_1c.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_subrt_ec2_1a" {
  subnet_id      = aws_subnet.web_subnet_ec2_1a.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_subrt_ec2_1c" {
  subnet_id      = aws_subnet.web_subnet_ec2_1c.id
  route_table_id = aws_route_table.web_rt.id
}

# ====================
#
# Private Subnet
#
# ====================

resource "aws_subnet" "web_subnet_rds_1a" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_rds_1a_cidr_block
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての無効化
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "web_subnet_rds_1a"
  }
}

resource "aws_subnet" "web_subnet_rds_1c" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.subnet_rds_1c_cidr_block
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "web_subnet_rds_1c"
  }
}

# ====================
#
# Private Subnet Group
#
# ====================
resource "aws_db_subnet_group" "web_subnet_db_group" {
  name       = "web_subnet_db_group"
  subnet_ids = [aws_subnet.web_subnet_rds_1a.id, aws_subnet.web_subnet_rds_1c.id]

  tags = {
    Name = "web_subnet_db_group"
  }
}
