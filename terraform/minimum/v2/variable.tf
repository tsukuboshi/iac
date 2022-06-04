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

# EC2 #
variable "instance_type" {
  default = "t3.micro"
}

variable "disable_api_termination" {
  default = "false" #本番環境ではtrueに変更
}

variable "ebs_optimized" {
  default = "true"
}

variable "ebs_device_name" {
  default = "/dev/xvda"
}

variable "ebs_volume_size" {
  default = 30
}

variable "ebs_volume_type" {
  default = "gp3"
}

variable "ebs_iops" {
  default = 3000
}

variable "ebs_throughput" {
  default = 125
}

variable "ebs_delete_on_termination" {
  default = "true"
}

variable "ebs_encrypted" {
  default = false
}

variable "user_data_file" {
  default = "./src/user_data.tpl"
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_enable_dns_support" {
  default = "true"
}

variable "vpc_enable_dns_hostnames" {
  default = "false"
}

variable "subnet_cidr_block_1" {
  default = "10.0.0.0/24"
}

variable "subnet_cidr_block_2" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "ap-northeast-1a"
}