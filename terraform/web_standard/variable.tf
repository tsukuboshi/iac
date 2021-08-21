
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

variable "user_data_file" {
  default = "./user_data.sh"
}

variable "key_name" {}

variable "public_key_file" {}

# VPC #
variable "availability_zone_1" {
  default = "ap-northeast-1a"
}

variable "availability_zone_2" {
  default = "ap-northeast-1c"
}
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
  default = "10.0.103.0/24"
}

variable "subnet_cidr_block_4" {
  default = "10.0.104.0/24"
}

variable "subnet_cidr_block_5" {
  default = "10.0.105.0/24"
}

variable "subnet_cidr_block_6" {
  default = "10.0.106.0/24"
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
