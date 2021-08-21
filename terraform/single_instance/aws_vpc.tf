# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "test_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true # DNS解決有効化
  enable_dns_hostnames = true # DNSホスト名有効化

  tags = {
    Name = "test_vpc"
  }
}

# ====================
#
# Subnet
#
# ====================

resource "aws_subnet" "test_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone

  tags = {
    Name = "test_subnet"
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
    Name = "test_gw"
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
    Name = "test_route_table"
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
