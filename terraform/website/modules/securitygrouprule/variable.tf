# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "security_group_id" {}

variable "sg_rule_type" {}

variable "sg_rule_protocol" {}

variable "sg_rule_from_port" {}

variable "sg_rule_to_port" {}

variable "sg_rule_cidr_blocks" {
  default = null
}

variable "sg_rule_source_security_group_id" {
  default = null
}
