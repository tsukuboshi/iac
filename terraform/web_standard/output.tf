# ====================
#
# Output
#
# ====================

output "public_ip_1a" {
  value       = aws_instance.web_instance_1a.public_ip
  description = "ap-northeast-1aに属するEC2インスタンスのパプリックIP"
}

output "public_ip_1c" {
  value       = aws_instance.web_instance_1c.public_ip
  description = "ap-northeast-1cに属するEC2インスタンスのパプリックIP"
}
