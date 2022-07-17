# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "internal" {}

variable "aurora_engine_version" {}

variable "security_group_id" {}

variable "db_instance_class" {}

variable "db_name" {
  default = null
}

variable "db_root_name" {}

variable "db_root_pass" {}

variable "db_storage_type" {}

variable "db_allocated_storage" {}

variable "db_max_allocated_storage" {}

variable "db_storage_encrypted" {}

variable "db_enabled_cloudwatch_logs_exports" {
  default = null
}

variable "db_backup_retention_period" {}

variable "db_backup_window" {}

variable "db_maintenance_window" {}

variable "db_performance_insights_enabled" {}

variable "db_performance_insights_retention_period" {}

variable "db_monitoring_role_arn" {}

variable "db_monitoring_interval" {}

variable "db_auto_minor_version_upgrade" {}

variable "isolated_1a_subnet_id" {}

variable "isolated_1c_subnet_id" {}
