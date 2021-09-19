# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "availability"
}

variable "environment" {
  default = "test"
}

# IAM #
variable "aws_profile" {
  default = "tf-demo" # AWSプロファイル
}

# EC2 #
variable "instance_type" {
  default = "t2.micro"
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "8"
}

variable "user_data_file" {
  default = "./src/user_data.sh"
}

variable "key_name" {
  default = "availability"
}

variable "public_key_file" {
  default = "~/.ssh/availability.pem.pub"
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block_1" {
  default = "10.0.1.0/24"
}

variable "subnet_cidr_block_2" {
  default = "10.0.2.0/24"
}

variable "subnet_cidr_block_3" {
  default = "10.0.3.0/24"
}

variable "subnet_cidr_block_4" {
  default = "10.0.4.0/24"
}

variable "subnet_cidr_block_5" {
  default = "10.0.5.0/24"
}

variable "subnet_cidr_block_6" {
  default = "10.0.6.0/24"
}

variable "availability_zone_1" {
  default = "ap-northeast-1a"
}

variable "availability_zone_2" {
  default = "ap-northeast-1c"
}


# RDS #
variable "db_password" {}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "storage_type" {
  default = "gp2"
}

variable "allocated_storage" {
  default = 20
}

variable "max_allocated_storage" {
  default = 50
}

variable "backup_window" {
  default = "04:00-05:00"
}

variable "backup_retention_period" {
  default = 7
}

variable "maintenance_window" {
  default = "Mon:05:00-Mon:08:00"
}

# ALB #

variable "idle_timeout" {
  default = 60
}

variable "deregistration_delay" {
  default = 300
}

variable "healthy_threshold" {
  default = 5
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 5
}


variable "interval" {
  default = 30
}

variable "matcher" {
  default = 200
}

# Route53 #

variable "domain" {
  default = "tf.com"
}
