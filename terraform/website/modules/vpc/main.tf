# ====================
#
# VPC
#
# ====================

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-vpc"
  }
}


# ====================
#
# Default Security Group
#
# ====================
resource "aws_default_security_group" "tf_default_security_group" {
  vpc_id = aws_vpc.tf_vpc.id
}

# ====================
#
# VPC Flow Log
#
# ====================
resource "aws_flow_log" "tf_flow_log" {
  count                    = var.has_flow_log ? 1 : 0
  vpc_id                   = aws_vpc.tf_vpc.id
  log_destination          = var.flow_log_bucket_arn
  traffic_type             = "ALL"
  max_aggregation_interval = 600
  log_destination_type     = "s3"

  destination_options {
    file_format                = var.flow_log_file_format
    hive_compatible_partitions = var.flow_log_hive_compatible_partitions
    per_hour_partition         = var.flow_log_per_hour_partition
  }

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-vpc-flow-log"
  }

  depends_on = [
    var.flow_log_bucket_arn
  ]
}
