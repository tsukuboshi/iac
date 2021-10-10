# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "container"
}

variable "environment" {
  default = "test"
}

# IAM #
variable "aws_profile" {
  default = "tf-demo"
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

variable "availability_zone_1" {
  default = "ap-northeast-1a"
}

variable "availability_zone_2" {
  default = "ap-northeast-1c"
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

variable "registered_domain" {}


# ECS #

variable "task_definitions_cpu" {
  default = 256
}

variable "task_definitions_memory" {
  default = 512
}

variable "container_definitions_file" {
  default = "./src/container_definitions.json"
}
