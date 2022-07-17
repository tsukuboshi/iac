# ====================
#
# Launch Template
#
# ====================

resource "aws_launch_template" "tf_lt" {
  name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-lt"

  image_id                = var.ami_image_id
  instance_type           = var.instance_type
  disable_api_termination = var.internal == true ? false : true
  ebs_optimized           = true

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = [var.security_group_id]
  }

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.key_pair_id

  user_data = filebase64(var.user_data_file)

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.ebs_volume_size
      volume_type           = var.ebs_volume_type
      delete_on_termination = true
      encrypted             = var.ebs_encrypted
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-asg-ec2"
    }
  }

  depends_on = [
    var.public_1a_ngw_id,
    var.public_1c_ngw_id
  ]
}

# ====================
#
# Auto Scailing Group
#
# ====================
resource "aws_autoscaling_group" "tf_asg" {
  name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-asg"

  launch_template {
    id      = aws_launch_template.tf_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    var.private_1a_subnet_id,
    var.private_1c_subnet_id
  ]

  target_group_arns         = [var.target_group_arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  metrics_granularity       = "1Minute"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolWarmedCapacity",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]

  desired_capacity = var.asg_desired_capacity
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size

  protect_from_scale_in = false
}

resource "aws_autoscaling_policy" "tf_autoscaling_policy" {
  name                   = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.tf_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50
  }
}
