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
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  user_data = templatefile(
    var.user_data_file,
    {
      EFS_ID       = aws_efs_file_system.tf_efs_file_system.id
      DB_HOST      = aws_rds_cluster.tf_rds_cluster.endpoint
      DB_NAME      = var.db_name
      DB_ROOT_NAME = var.db_root_name
      DB_ROOT_PASS = var.db_root_pass
      DB_USER_NAME = var.db_user_name
      DB_USER_PASS = var.db_user_pass
      AZ_1         = var.availability_zone_1
    }
  )
  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    iops                  = var.ebs_iops
    throughput            = var.ebs_throughput
    delete_on_termination = var.ebs_delete_on_termination
    encrypted             = var.ebs_encrypted
    tags = {
      Name = "${var.project}-${var.environment}-ebs-web-1a"
    }
  }

  tags = {
    Name = "${var.project}-${var.environment}-ec2-web-1a"
  }

  depends_on = [
    aws_nat_gateway.tf_ngw_1a, aws_rds_cluster_instance.tf_rds_cluster_instance
  ]
}

resource "aws_instance" "tf_instance_1c" {
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tf_subnet_4.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.tf_sg_ec2.id]
  ami                         = data.aws_ami.tf_ami.image_id
  iam_instance_profile        = aws_iam_instance_profile.tf_instance_profile_ssm.name
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.ebs_optimized

  user_data = templatefile(
    var.user_data_file,
    {
      EFS_ID       = aws_efs_file_system.tf_efs_file_system.id
      DB_HOST      = aws_rds_cluster.tf_rds_cluster.endpoint
      DB_NAME      = var.db_name
      DB_ROOT_NAME = var.db_root_name
      DB_ROOT_PASS = var.db_root_pass
      DB_USER_NAME = var.db_user_name
      DB_USER_PASS = var.db_user_pass
      AZ_1         = var.availability_zone_1
    }
  )

  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    iops                  = var.ebs_iops
    throughput            = var.ebs_throughput
    delete_on_termination = var.ebs_delete_on_termination
    encrypted             = var.ebs_encrypted
    tags = {
      Name = "${var.project}-${var.environment}-ebs-web-1c"
    }
  }

  tags = {
    Name = "${var.project}-${var.environment}-ec2-web-1c"
  }

  depends_on = [
    aws_nat_gateway.tf_ngw_1c, aws_rds_cluster_instance.tf_rds_cluster_instance
  ]
}
