# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "minimum"
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
  default = "single_instance"
}

variable "public_key_file" {
  default = "~/.ssh/single_instance.pem.pub"
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "ap-northeast-1a"
}
