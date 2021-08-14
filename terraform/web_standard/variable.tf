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

variable "subnet_alb_1a_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_alb_1c_cidr_block" {
  default = "10.0.2.0/24"

}

variable "subnet_ec2_1a_cidr_block" {
  default = "10.0.3.0/24"
}

variable "subnet_ec2_1c_cidr_block" {
  default = "10.0.4.0/24"
}

variable "subnet_rds_1a_cidr_block" {
  default = "10.0.5.0/24"
}

variable "subnet_rds_1c_cidr_block" {
  default = "10.0.6.0/24"
}

# RDS #

variable "db_allocated_storage" {
  default = "20"
}

variable "db_storage_type" {
  default = "gp2"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "8.0"
}

variable "db_instance_class" {
  default = "db.t2.micro"
}

variable "db_username" {}

variable "db_password" {}

variable "db_parameter_group_name" {
  default = "default.mysql8.0"
}