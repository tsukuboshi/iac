# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "tf_vpc" {
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

resource "aws_subnet" "tf_subnet_1" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_1
  map_public_ip_on_launch = true #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-1"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Private Subnet
#
# ====================

resource "aws_subnet" "tf_subnet_2" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  map_public_ip_on_launch = false #インスタンス起動時におけるパブリックIPアドレスの自動割り当ての有効化
  availability_zone       = var.availability_zone

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-3"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Internet Gateway
#
# ====================
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name    = "${var.project}-${var.environment}-igw"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Elastic IP
#
# ====================

resource "aws_eip" "tf_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.tf_igw]

  tags = {
    Name    = "${var.project}-${var.environment}-eip"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Nat Gateway
#
# ====================

resource "aws_nat_gateway" "tf_ngw" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id     = aws_subnet.tf_subnet_1.id

  tags = {
    Name = "${var.project}-${var.environment}-ngw"
  }

  depends_on = [aws_eip.tf_eip]
}

# ====================
#
# Public Route Table
#
# ====================
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-rt"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "tf_public_route" {
  route_table_id         = aws_route_table.tf_public_rt.id
  gateway_id             = aws_internet_gateway.tf_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_public_subrt" {
  subnet_id      = aws_subnet.tf_subnet_1.id
  route_table_id = aws_route_table.tf_public_rt.id
}


# ====================
#
# Private Route Table
#
# ====================
resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-private-rt"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_route" "tf_private_route" {
  route_table_id         = aws_route_table.tf_private_rt.id
  gateway_id             = aws_nat_gateway.tf_ngw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_private_subrt_2" {
  subnet_id      = aws_subnet.tf_subnet_2.id
  route_table_id = aws_route_table.tf_private_rt.id
}
