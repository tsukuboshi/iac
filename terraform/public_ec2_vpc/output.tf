# ====================
#
# Output
#
# ====================

output "public_ip" {
  value       = aws_instance.test_instance.public_ip
  description = "EC2インスタンスのパプリックIP"
}
