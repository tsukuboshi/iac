# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

# IAM #
variable "aws_profile" {}

# EC2 #
variable "instance_type" {}

variable "volume_type" {}

variable "volume_size" {}

variable "key_name" {}

variable "public_key" {}

variable "user_data" {}

# VPC #
variable "cidr_block" {}

variable "subnet_cidr_block" {}
