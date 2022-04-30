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

resource "aws_instance" "tf_instance_1a" {
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tf_subnet_3.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.tf_sg_ec2.id]
  ami                         = data.aws_ami.tf_ami.image_id
  iam_instance_profile        = aws_iam_instance_profile.tf_instance_profile_ssm.name
  user_data                   = file(var.user_data_file)
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  ebs_block_device {
    device_name           = var.device_name
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    iops                  = var.iops
    throughput            = var.throughput
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted
    tags = {
      Name = "${var.project}-${var.environment}-web-register-1a"
    }
  }

  tags = {
    Name = "${var.project}-${var.environment}-web-register-1a"
  }

  depends_on = [
    aws_nat_gateway.tf_ngw_1a
  ]
}

resource "aws_instance" "tf_instance_1c" {
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tf_subnet_4.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.tf_sg_ec2.id]
  ami                         = data.aws_ami.tf_ami.image_id
  iam_instance_profile        = aws_iam_instance_profile.tf_instance_profile_ssm.name
  user_data                   = file(var.user_data_file)
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  ebs_block_device {
    device_name           = var.device_name
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    iops                  = var.iops
    throughput            = var.throughput
    delete_on_termination = var.delete_on_termination
    encrypted             = var.encrypted
    tags = {
      Name = "${var.project}-${var.environment}-web-register-1c"
    }
  }

  tags = {
    Name = "${var.project}-${var.environment}-web-register-1c"
  }

  depends_on = [
    aws_nat_gateway.tf_ngw_1c
  ]
}
