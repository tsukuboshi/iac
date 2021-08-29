# ====================
#
# EC2 Instance
#
# ====================

resource "aws_instance" "example_instance_1a" {
  ami                         = data.aws_ami.example_ami.image_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.example_subnet_1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example_sg_ec2.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  key_name  = aws_key_pair.example_key.id
  user_data = file(var.user_data_file)

  tags = {
    Name    = "${var.project}-${var.environment}-ec2-1a"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_instance" "example_instance_1c" {
  ami                         = data.aws_ami.example_ami.image_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.example_subnet_2.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.example_sg_ec2.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  key_name  = aws_key_pair.example_key.id
  user_data = file(var.user_data_file)

  tags = {
    Name    = "${var.project}-${var.environment}-ec2-1c"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Key Pair
#
# ====================

resource "aws_key_pair" "example_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}
