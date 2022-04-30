# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "tf_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "${var.project}-${var.environment}-vpc"
  }
}

# ====================
#
# Subnet
#
# ====================

#ALB用パブリックサブネット
resource "aws_subnet" "tf_subnet_1" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_1
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "${var.project}-${var.environment}-frontend-subnet-1a"
  }
}

resource "aws_subnet" "tf_subnet_2" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_2
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "${var.project}-${var.environment}-frontend-subnet-1c"
  }
}

#EC2用プライベートサブネット
resource "aws_subnet" "tf_subnet_3" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_3
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "${var.project}-${var.environment}-application-subnet-1a"
  }
}

resource "aws_subnet" "tf_subnet_4" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_4
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "${var.project}-${var.environment}-application-subnet-1c"
  }
}

#RDS用プライベートサブネット
resource "aws_subnet" "tf_subnet_5" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_5
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone_1

  tags = {
    Name = "${var.project}-${var.environment}-datastore-subnet-1a"
  }
}

resource "aws_subnet" "tf_subnet_6" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.subnet_cidr_block_6
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone_2

  tags = {
    Name = "${var.project}-${var.environment}-datastore-subnet-1c"
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
# Elastic IP
#
# ====================

resource "aws_eip" "tf_eip_1a" {
  vpc        = true
  depends_on = [aws_internet_gateway.tf_igw]

  tags = {
    Name = "${var.project}-${var.environment}-ngw-1a-eip"
  }
}

resource "aws_eip" "tf_eip_1c" {
  vpc        = true
  depends_on = [aws_internet_gateway.tf_igw]

  tags = {
    Name = "${var.project}-${var.environment}-ngw-1c-eip"
  }
}

# ====================
#
# Nat Gateway
#
# ====================

resource "aws_nat_gateway" "tf_ngw_1a" {
  allocation_id = aws_eip.tf_eip_1a.id
  subnet_id     = aws_subnet.tf_subnet_1.id

  tags = {
    Name = "${var.project}-${var.environment}-ngw-1a"
  }

  depends_on = [aws_eip.tf_eip_1a]
}

resource "aws_nat_gateway" "tf_ngw_1c" {
  allocation_id = aws_eip.tf_eip_1c.id
  subnet_id     = aws_subnet.tf_subnet_2.id

  tags = {
    Name = "${var.project}-${var.environment}-ngw-1c"
  }

  depends_on = [aws_eip.tf_eip_1c]
}

# ====================
#
# Route Table
#
# ====================

#ALB用ルートテーブル
resource "aws_route_table" "tf_rtb_1" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-frontend-rtb"
  }
}

resource "aws_route" "tf_route_1_1" {
  route_table_id         = aws_route_table.tf_rtb_1.id
  gateway_id             = aws_internet_gateway.tf_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_rtbsub_1_1" {
  route_table_id = aws_route_table.tf_rtb_1.id
  subnet_id      = aws_subnet.tf_subnet_1.id
}

resource "aws_route_table_association" "tf_rtbsub_1_2" {
  route_table_id = aws_route_table.tf_rtb_1.id
  subnet_id      = aws_subnet.tf_subnet_2.id
}

#EC2用ルートテーブル
resource "aws_route_table" "tf_rtb_2" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-application-1a-rtb"
  }
}

resource "aws_route" "tf_route_2_1" {
  route_table_id         = aws_route_table.tf_rtb_2.id
  nat_gateway_id         = aws_nat_gateway.tf_ngw_1a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_rtbsub_2_1" {
  route_table_id = aws_route_table.tf_rtb_2.id
  subnet_id      = aws_subnet.tf_subnet_3.id
}

resource "aws_route_table" "tf_rtb_3" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-application-1c-rtb"
  }
}

resource "aws_route" "tf_route_3_1" {
  route_table_id         = aws_route_table.tf_rtb_3.id
  nat_gateway_id         = aws_nat_gateway.tf_ngw_1c.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "tf_subrtb_3_1" {
  route_table_id = aws_route_table.tf_rtb_3.id
  subnet_id      = aws_subnet.tf_subnet_4.id
}

#EDS用ルートテーブル
resource "aws_route_table" "tf_rtb_4" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-datastore-rtb"
  }
}

resource "aws_route_table_association" "tf_rtbsub_4_1" {
  route_table_id = aws_route_table.tf_rtb_4.id
  subnet_id      = aws_subnet.tf_subnet_5.id
}

resource "aws_route_table_association" "tf_rtbsub_4_2" {
  route_table_id = aws_route_table.tf_rtb_4.id
  subnet_id      = aws_subnet.tf_subnet_6.id
}

# ====================
#
# Network ACL
#
# ====================

#ALB用ネットワークACL
resource "aws_network_acl" "tf_nacl_1" {
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.project}-${var.environment}-frontend-nacl"
  }
}

resource "aws_network_acl_association" "tf_naclsub_1_1" {
  network_acl_id = aws_network_acl.tf_nacl_1.id
  subnet_id      = aws_subnet.tf_subnet_1.id
}

resource "aws_network_acl_association" "tf_naclsub_1_2" {
  network_acl_id = aws_network_acl.tf_nacl_1.id
  subnet_id      = aws_subnet.tf_subnet_2.id
}

#EC2用ネットワークACL
resource "aws_network_acl" "tf_nacl_2" {
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.project}-${var.environment}-application-nacl"
  }
}

resource "aws_network_acl_association" "tf_naclsub_2_1" {
  network_acl_id = aws_network_acl.tf_nacl_2.id
  subnet_id      = aws_subnet.tf_subnet_3.id
}

resource "aws_network_acl_association" "tf_naclsub_2_2" {
  network_acl_id = aws_network_acl.tf_nacl_2.id
  subnet_id      = aws_subnet.tf_subnet_4.id
}

#RDS用ネットワークACL
resource "aws_network_acl" "tf_nacl_3" {
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.project}-${var.environment}-datastore-nacl"
  }
}

resource "aws_network_acl_association" "tf_naclsub_3_1" {
  network_acl_id = aws_network_acl.tf_nacl_3.id
  subnet_id      = aws_subnet.tf_subnet_5.id
}

resource "aws_network_acl_association" "tf_naclsub_3_2" {
  network_acl_id = aws_network_acl.tf_nacl_3.id
  subnet_id      = aws_subnet.tf_subnet_6.id
}

# ====================
#
# VPC Flow Log
#
# ====================
resource "aws_flow_log" "tf_flow_log" {
  vpc_id                   = aws_vpc.tf_vpc.id
  log_destination          = aws_s3_bucket.tf_bucket_vpc_log.arn
  traffic_type             = var.traffic_type
  max_aggregation_interval = var.max_aggregation_interval
  log_destination_type     = "s3"

  destination_options {
    file_format                = var.file_format
    hive_compatible_partitions = var.hive_compatible_partitions
    per_hour_partition         = var.per_hour_partition
  }

  tags = {
    Name = "${var.project}-${var.environment}-vpc-flow-log"
  }

  depends_on = [
    aws_s3_bucket.tf_bucket_vpc_log
  ]
}
