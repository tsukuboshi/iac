# ====================
#
# Subnet
#
# ====================

resource "aws_subnet" "tf_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone       = var.subnet_availability_zone

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-subnet"
  }
}
