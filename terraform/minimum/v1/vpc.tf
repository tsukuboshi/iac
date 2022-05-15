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
    Name = "${var.project}-${var.environment}-vpc"
  }
}

# ====================
#
# Subnet
#
# ====================

#パブリックサブネット
resource "aws_subnet" "tf_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = "${var.project}-${var.environment}-subnet"
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
    Name = "${var.project}-${var.environment}-igw"
  }
}

# ====================
#
# Route Table
#
# ====================
resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-rt"
  }
}

resource "aws_route" "tf_route" {
  route_table_id         = aws_route_table.tf_rt.id
  gateway_id             = aws_internet_gateway.tf_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_subrt" {
  subnet_id      = aws_subnet.tf_subnet.id
  route_table_id = aws_route_table.tf_rt.id
}
