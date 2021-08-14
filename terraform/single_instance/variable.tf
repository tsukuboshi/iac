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
variable "instance_type" {
  default = "t2.micro"
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "8"
}

variable "user_data" {
  default = "./user_data.sh"
}

variable "key_name" {}

variable "public_key" {}

# VPC #
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}
