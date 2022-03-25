# ====================
#
# Output
#
# ====================

output "instance_public_ip" {
  value = aws_instance.tf_instance.public_ip
}
