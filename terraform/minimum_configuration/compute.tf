# ====================
#
# EC2 Instance
#
# ====================

resource "aws_instance" "example_instance" {
  ami                    = data.aws_ami.example_ami.image_id
  key_name               = aws_key_pair.example_key.id
  subnet_id              = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  instance_type          = var.instance_type
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = "true"
  }

  user_data = file(var.user_data_file)

  tags = {
    Name    = "${var.project}-${var.environment}-ec2"
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
}
