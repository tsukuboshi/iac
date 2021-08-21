# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "web_vpc" {
  cidr_block           = var.vpc_cidr_block
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

resource "aws_subnet" "web_subnet_1" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_1
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "web_subnet_1"
  }
}

resource "aws_subnet" "web_subnet_2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "web_subnet_2"
  }
}

resource "aws_subnet" "web_subnet_3" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_3
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "web_subnet_3"
  }
}

resource "aws_subnet" "web_subnet_4" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_4
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "web_subnet_4"
  }
}

# ====================
#
# Private Subnet
#
# ====================

resource "aws_subnet" "web_subnet_5" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_5
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての無効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "web_subnet_5"
  }
}

resource "aws_subnet" "web_subnet_6" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = var.subnet_cidr_block_6
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "web_subnet_6"
  }
}


# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_igw"
  }
}

# ====================
#
# Route Table
#
# ====================
resource "aws_route_table" "web_public_rt" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    Name = "web_public_rt"
  }
}

resource "aws_route" "web_public_route" {
  route_table_id         = aws_route_table.web_public_rt.id
  gateway_id             = aws_internet_gateway.web_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "web_public_subrt_1" {
  subnet_id      = aws_subnet.web_subnet_1.id
  route_table_id = aws_route_table.web_public_rt.id
}

resource "aws_route_table_association" "web_public_subrt_2" {
  subnet_id      = aws_subnet.web_subnet_2.id
  route_table_id = aws_route_table.web_public_rt.id
}

resource "aws_route_table_association" "web_public_subrt_3" {
  subnet_id      = aws_subnet.web_subnet_3.id
  route_table_id = aws_route_table.web_public_rt.id
}

resource "aws_route_table_association" "web_public_subrt_4" {
  subnet_id      = aws_subnet.web_subnet_4.id
  route_table_id = aws_route_table.web_public_rt.id
}

# ====================
#
# Private Subnet Group
#
# ====================
resource "aws_db_subnet_group" "web_subnet_db_group" {
  name       = "web_subnet_db_group"
  subnet_ids = [aws_subnet.web_subnet_3.id, aws_subnet.web_subnet_4.id]

  tags = {
    Name = "web_subnet_db_group"
  }
}
