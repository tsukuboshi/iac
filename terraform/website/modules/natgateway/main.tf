# ====================
#
# Elastic IP
#
# ====================

resource "aws_eip" "tf_eip" {
  vpc        = true
  depends_on = [var.igw_id]

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-eip"
  }
}

# ====================
#
# Nat Gateway
#
# ====================

resource "aws_nat_gateway" "tf_ngw" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-ngw"
  }
}

# ====================
#
# Route
#
# ====================

resource "aws_route" "tf_route_ngw" {
  route_table_id         = var.route_table_id
  nat_gateway_id         = aws_nat_gateway.tf_ngw.id
  destination_cidr_block = "0.0.0.0/0"
}
