# ====================
#
# Outputs
#
# ====================

output "instance_profile" {
  value = aws_iam_instance_profile.tf_instance_profile_ssm.name
}
