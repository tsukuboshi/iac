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

variable "has_subnet_1a" {
  default = false
}

variable "has_subnet_1c" {
  default = false
}

variable "subnet_1a_id" {
  default = null
}

variable "subnet_1c_id" {
  default = null
}
