# ====================
#
# AMI
#
# ====================
# 最新版のAmazonLinux2のAMI情報
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
  subnet_id                   = aws_subnet.tf_subnet_2.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.tf_sg.id]
  ami                         = data.aws_ami.tf_ami.image_id
  iam_instance_profile        = aws_iam_instance_profile.tf_instance_profile_ssm.name
  user_data                   = file(var.user_data_file)
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    iops                  = var.ebs_iops
    throughput            = var.ebs_throughput
    delete_on_termination = var.ebs_delete_on_termination
    encrypted             = var.ebs_encrypted
    tags = {
      Name = "${var.project}-${var.environment}-1a"
    }
  }

  key_name = aws_key_pair.tf_key.id
  tags = {
    Name = "${var.project}-${var.environment}-1a"
  }

  depends_on = [
    aws_nat_gateway.tf_ngw
  ]
}
