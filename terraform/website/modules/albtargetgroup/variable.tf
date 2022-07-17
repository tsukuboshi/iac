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

variable "has_instance_1a" {
  default = false
}

variable "has_instance_1c" {
  default = false
}

variable "instance_1a_id" {
  default = null
}

variable "instance_1c_id" {
  default = null
}

variable "alb_lsnr_https_arn" {}

variable "alb_lsnr_rule_priority" {}

variable "has_host_header" {
  default = false
}

variable "has_path_pattern" {
  default = false
}

variable "alb_lsnr_rule_host_header" {
  default = null
}

variable "alb_lsnr_rule_pass_pattern" {
  default = null
}
