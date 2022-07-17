# ====================
#
# Outputs
#
# ====================

output "security_group_id" {
  value = aws_security_group.tf_sg.id
}
