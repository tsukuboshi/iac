# ====================
#
# AMI
#
# ====================
# 最新版のAmazonLinux2のAMI情報
data "aws_ami" "test_ami" {
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

resource "aws_instance" "test_instance" {
  ami                    = data.aws_ami.test_ami.image_id
  key_name               = aws_key_pair.test_key.id
  subnet_id              = aws_subnet.test_subnet.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  instance_type          = var.instance_type
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = "true"
  }

  user_data = file(var.user_data_file)

  tags = {
    Name = "test_instance"
  }
}

# ====================
#
# Key Pair
#
# ====================

resource "aws_key_pair" "test_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)
}
