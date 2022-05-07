# ====================
#
# File System
#
# ====================
resource "aws_efs_file_system" "tf_efs_file_system" {
  tags = {
    Name = "${var.project}-${var.environment}-web-efs"
  }
}

# ====================
#
# Mount Target
#
# ====================
resource "aws_efs_mount_target" "tf_efs_mount_target_1a" {
  file_system_id = aws_efs_file_system.tf_efs_file_system.id
  subnet_id      = aws_subnet.tf_subnet_3.id
  security_groups = [
    aws_security_group.tf_sg_efs  .id
  ]
}

resource "aws_efs_mount_target" "tf_efs_mount_target_1c" {
  file_system_id = aws_efs_file_system.tf_efs_file_system.id
  subnet_id      = aws_subnet.tf_subnet_4.id
  security_groups = [
    aws_security_group.tf_sg_efs.id
  ]
}
