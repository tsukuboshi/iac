# ====================
#
# Security Group Rule
#
# ====================

resource "aws_security_group_rule" "tf_sg_rule" {
  security_group_id        = var.security_group_id
  type                     = var.sg_rule_type
  protocol                 = var.sg_rule_protocol
  from_port                = var.sg_rule_from_port
  to_port                  = var.sg_rule_to_port
  cidr_blocks              = var.sg_rule_cidr_blocks
  source_security_group_id = var.sg_rule_source_security_group_id
}
