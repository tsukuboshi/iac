# ====================
#
# Network ACL
#
# ====================

resource "aws_network_acl" "tf_nacl" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-nacl"
  }
}

resource "aws_network_acl_rule" "tf_nacl_ingress_rule" {
  network_acl_id = aws_network_acl.tf_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "tf_nacl_egress_rule" {
  network_acl_id = aws_network_acl.tf_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_association" "tf_naclsub_1a" {
  network_acl_id = aws_network_acl.tf_nacl.id
  subnet_id      = var.subnet_1a_id
}

resource "aws_network_acl_association" "tf_naclsub_1c" {
  network_acl_id = aws_network_acl.tf_nacl.id
  subnet_id      = var.subnet_1c_id
}
