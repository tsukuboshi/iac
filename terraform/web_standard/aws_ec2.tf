# ====================
#
# AMI
#
# ====================
# 最新版のAmazonLinux2のAMI情報
data "aws_ami" "web_ami" {
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

resource "aws_instance" "web_instance_1a" {
  ami                    = data.aws_ami.web_ami.image_id
  key_name               = aws_key_pair.web_key.id
  subnet_id              = aws_subnet.web_subnet_ec2_1a.id
  vpc_security_group_ids = [aws_security_group.web_sg_ec2.id]
  instance_type          = var.instance_type
  root_block_device {
    volume_type          = var.volume_type
    volume_size          = var.volume_size
  }
  user_data              = file(var.user_data_file)

  tags = {
    Name = "web_instance_1a"
  }
}

resource "aws_instance" "web_instance_1c" {
  ami                    = data.aws_ami.web_ami.image_id
  key_name               = aws_key_pair.web_key.id
  subnet_id              = aws_subnet.web_subnet_ec2_1c.id
  vpc_security_group_ids = [aws_security_group.web_sg_ec2.id]
  instance_type          = var.instance_type
  root_block_device {
    volume_type          = var.volume_type
    volume_size          = var.volume_size
  }
  user_data              = file(var.user_data_file)

  tags = {
    Name = "web_instance_1c"
  }

}

# ====================
#
# Key Pair
#
# ====================

resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)
}
