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
# Public Subnet
#
# ====================

resource "aws_subnet" "example_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_1
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-1"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_subnet" "example_subnet_2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-2"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_subnet" "example_subnet_3" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_3
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-3"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_subnet" "example_subnet_4" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_4
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-4"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Private Subnet
#
# ====================

resource "aws_subnet" "example_subnet_5" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_5
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての無効化
  availability_zone       = var.availability_zone_1

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-5"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_subnet" "example_subnet_6" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.subnet_cidr_block_6
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone_2

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-6"
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
resource "aws_route_table" "example_public_rt" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-rt"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "example_public_route" {
  route_table_id         = aws_route_table.example_public_rt.id
  gateway_id             = aws_internet_gateway.example_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "example_public_subrt_1" {
  subnet_id      = aws_subnet.example_subnet_1.id
  route_table_id = aws_route_table.example_public_rt.id
}

resource "aws_route_table_association" "example_public_subrt_2" {
  subnet_id      = aws_subnet.example_subnet_2.id
  route_table_id = aws_route_table.example_public_rt.id
}

resource "aws_route_table_association" "example_public_subrt_3" {
  subnet_id      = aws_subnet.example_subnet_3.id
  route_table_id = aws_route_table.example_public_rt.id
}

resource "aws_route_table_association" "example_public_subrt_4" {
  subnet_id      = aws_subnet.example_subnet_4.id
  route_table_id = aws_route_table.example_public_rt.id
}
