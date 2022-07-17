# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "internal" {}

variable "subnet_1a_id" {}

variable "subnet_1c_id" {}

variable "security_group_id" {}

variable "has_access_logs" {
  default = false
}

variable "access_log_bucket_name" {
  default = null
}

variable "access_log_prefix" {
  default = null
}

variable "acm_alb_cert_arn" {}

variable "acm_alb_cert_valid_id" {}
