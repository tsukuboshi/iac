# ====================
#
# Outputs
#
# ====================

output "ami_image_id" {
  value = data.aws_ami.tf_ami.image_id
}
