# ====================
#
# Key Pair
#
# ====================

resource "aws_key_pair" "tf_key" {
  count      = var.has_key_pair ? 1 : 0
  key_name   = "${var.system}-${var.project}-${var.environment}-keypair"
  public_key = file(var.public_key_file)

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-keypair"
  }
}
