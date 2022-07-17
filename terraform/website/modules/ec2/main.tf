# ====================
#
# AMI
#
# ====================

data "aws_ami" "tf_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


# ====================
#
# EC2 Instance
#
# ====================

resource "aws_instance" "tf_instance" {
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [var.security_group_id]
  ami                         = var.ami_image_id
  iam_instance_profile        = var.instance_profile
  disable_api_termination     = var.internal == true ? false : true
  ebs_optimized               = true

  key_name = var.key_pair_id

  user_data = file(var.user_data_file)

  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    delete_on_termination = true
    encrypted             = var.ebs_encrypted

    tags = {
      Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-ebs"
    }
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-instance"
  }

  depends_on = [
    var.public_ngw_id
  ]
}
