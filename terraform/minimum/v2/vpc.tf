# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = {
    Name    = "${var.project}-${var.environment}-vpc"
  }
}

# ====================
#
# Subnet
#
# ====================

#パプリックサブネット

resource "aws_subnet" "tf_subnet_1" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-1"
  }
}

#プライベートサブネット

resource "aws_subnet" "tf_subnet_2" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone

  tags = {
    Name    = "${var.project}-${var.environment}-subnet-2"
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
# Route Table
#
# ====================

#パブリックルートテーブル
resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-rt"
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

#プライベートルートテーブル
resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-private-rt"
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
