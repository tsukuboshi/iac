# ====================
#
# Instance Profile
#
# ====================

resource "aws_iam_instance_profile" "tf_instance_profile" {
  name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-instance-profile"
  role = var.ec2_role_arn

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-instance-profile"
  }
}
