# ====================
#
# Route Table
#
# ====================

resource "aws_route_table" "tf_rtb" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-rtb"
  }
}

resource "aws_route_table_association" "tf_rtbsub_1a" {
  count          = var.has_subnet_1a ? 1 : 0
  route_table_id = aws_route_table.tf_rtb.id
  subnet_id      = var.subnet_1a_id
}

resource "aws_route_table_association" "tf_rtbsub_1c" {
  count          = var.has_subnet_1c ? 1 : 0
  route_table_id = aws_route_table.tf_rtb.id
  subnet_id      = var.subnet_1c_id
}
