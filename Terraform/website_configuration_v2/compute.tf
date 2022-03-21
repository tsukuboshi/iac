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
# Key Pair
#
# ====================

resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

# ====================
#
# Launch Template
#
# ====================
resource "aws_launch_template" "tf_lt" {
  update_default_version = true

  name = "${var.project}-${var.environment}-lt"

  image_id = data.aws_ami.tf_ami.id

  key_name = aws_key_pair.tf_key.key_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "${var.project}-${var.environment}-asg-ec2"
      Project = var.project
      Env     = var.environment
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [
      aws_security_group.tf_sg_ec2.id
    ]
    delete_on_termination = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.tf_instance_profile.name
  }

  user_data = filebase64(var.user_data_file)
}

# ====================
#
# Auto Scailing Group
#
# ====================
resource "aws_autoscaling_group" "tf_asg" {
  name = "${var.project}-${var.environment}-asg"

  max_size           = var.max_size
  min_size           = var.min_size
  desired_capacity   = var.desired_capacity

  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.tf_subnet_3.id,
    aws_subnet.tf_subnet_4.id
  ]

  target_group_arns = [aws_lb_target_group.tf_alb_tg.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.tf_lt.id
        version            = "$Latest"
      }

      override {
        instance_type = var.instance_type
      }
    }
  }
}
