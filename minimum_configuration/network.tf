# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "example_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true # DNS解決有効化
  enable_dns_hostnames = true # DNSホスト名有効化

  tags = {
    Name    = "${var.project}-${var.environment}-vpc"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Subnet
#
# ====================

resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone

  tags = {
    Name    = "${var.project}-${var.environment}-subnet"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-igw"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Route Table
#
# ====================
resource "aws_route_table" "example_rt" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-rt"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "example_route" {
  route_table_id         = aws_route_table.example_rt.id
  gateway_id             = aws_internet_gateway.example_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example_subrt" {
  subnet_id      = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_rt.id
}
