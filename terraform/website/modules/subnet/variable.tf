# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "vpc_id" {}

variable "subnet_cidr_block" {}

variable "subnet_map_public_ip_on_launch" {
  default = false
}

variable "subnet_availability_zone" {}
