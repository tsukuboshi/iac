# ====================
#
# Outputs
#
# ====================

output "instance_id" {
  value = aws_instance.tf_instance.id
}

output "instance_arn" {
  value = aws_instance.tf_instance.arn
}
