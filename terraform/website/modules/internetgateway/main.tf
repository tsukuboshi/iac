# ====================
#
# Internet Gateway
#
# ====================

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-igw"
  }
}

# ====================
#
# Route
#
# ====================

resource "aws_route" "tf_route_igw" {
  route_table_id         = var.route_table_id
  gateway_id             = aws_internet_gateway.tf_igw.id
  destination_cidr_block = "0.0.0.0/0"
}
