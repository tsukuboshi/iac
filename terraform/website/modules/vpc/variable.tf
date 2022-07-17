# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "vpc_cidr_block" {}

variable "vpc_enable_dns_hostnames" {
  default = false
}

variable "has_flow_log" {
  default = false
}

variable "flow_log_bucket_arn" {
  default = null
}

variable "flow_log_file_format" {
  default = null
}

variable "flow_log_hive_compatible_partitions" {
  default = null
}

variable "flow_log_per_hour_partition" {
  default = null
}
