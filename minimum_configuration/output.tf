# ====================
#
# Output
#
# ====================

output "instance_public_ip" {
  value       = aws_instance.example_instance.public_ip
}
