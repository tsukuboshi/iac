# ====================
#
# Launch Template
#
# ====================

resource "aws_launch_template" "tf_lt" {
  name = "${var.project}-${var.environment}-web-view-launch-template"

  image_id      = data.aws_ami.tf_ami.image_id
  instance_type = var.instance_type
  iam_instance_profile {
    name = aws_iam_instance_profile.tf_instance_profile_ssm.name
  }

  vpc_security_group_ids  = [aws_security_group.tf_sg_ec2.id]
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      iops                  = var.iops
      throughput            = var.throughput
      delete_on_termination = var.delete_on_termination
      encrypted             = var.encrypted
    }
  }

  user_data = filebase64("./src/user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project}-${var.environment}-web-view"
    }
  }

  depends_on = [
    aws_nat_gateway.tf_ngw_1a,
    aws_nat_gateway.tf_ngw_1c
  ]
}

# ====================
#
# Auto Scailing Group
#
# ====================
resource "aws_autoscaling_group" "tf_asg" {
  name = "${var.project}-${var.environment}-asg"

  launch_template {
    id      = aws_launch_template.tf_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.tf_subnet_3.id,
    aws_subnet.tf_subnet_4.id
  ]

  target_group_arns         = [aws_lb_target_group.tf_alb_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = var.health_check_grace_period
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
    "WarmPoolPendingCapacity", "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity", "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity"
  ]

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  protect_from_scale_in = var.protect_from_scale_in
}

resource "aws_autoscaling_policy" "tf_autoscaling_policy" {
  name                   = "${var.project}-${var.environment}-asg-policy"
  autoscaling_group_name = aws_autoscaling_group.tf_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}
