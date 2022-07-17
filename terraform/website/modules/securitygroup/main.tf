# ====================
#
# Security Group
#
# ====================

resource "aws_security_group" "tf_sg" {
  name   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-sg"
  }
}
