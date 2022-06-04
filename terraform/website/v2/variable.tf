# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

variable "project" {
  default = "website"
}

variable "environment" {
  default = "test"
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
}

variable "subnet_cidr_block_1" {
  default = "10.0.0.0/24"
}

variable "subnet_cidr_block_2" {
  default = "10.0.1.0/24"
}

variable "subnet_cidr_block_3" {
  default = "10.0.2.0/24"
}

variable "subnet_cidr_block_4" {
  default = "10.0.3.0/24"
}

variable "subnet_cidr_block_5" {
  default = "10.0.4.0/24"
}

variable "subnet_cidr_block_6" {
  default = "10.0.5.0/24"
}

variable "availability_zone_1" {
  default = "ap-northeast-1a"
}

variable "availability_zone_2" {
  default = "ap-northeast-1c"
}

variable "traffic_type" {
  default = "ALL"
}

variable "max_aggregation_interval" {
  default = 600
}

# S3 #
variable "force_destroy" {
  default = "true" #本番環境ではfalseに変更
}

variable "expiration_days" {
  default = 400
}

variable "file_format" {
  default = "parquet"
}

variable "hive_compatible_partitions" {
  default = "true"
}

variable "per_hour_partition" {
  default = "false"
}

# EC2 #
variable "instance_type" {
  default = "t3.micro"
}

variable "disable_api_termination" {
  default = "false" #本番環境ではtrueに変更
}

variable "ebs_optimized" {
  default = "true"
}

variable "ebs_device_name" {
  default = "/dev/xvda"
}

variable "ebs_volume_size" {
  default = 30
}

variable "ebs_volume_type" {
  default = "gp3"
}

variable "ebs_iops" {
  default = 3000
}

variable "ebs_throughput" {
  default = 125
}

variable "ebs_delete_on_termination" {
  default = "true"
}

variable "ebs_encrypted" {
  default = false
}

variable "user_data_file" {
  default = "./src/user_data_am.tpl"
}

# ALB #

variable "alb_log_prefix" {
  default = "alb-log"
}

variable "enable_deletion_protection" {
  default = "false" #本番環境ではtrueに変更
}

variable "deregistration_delay" {
  default = 300
}

variable "slow_start" {
  default = 0
}

variable "load_balancing_algorithm_type" {
  default = "round_robin"
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

# RDS #
variable "db_instance_count" {
  default = 1
}

variable "db_instance_class" {
  default = "db.r6g.large"
}

variable "db_name" {
  default = "wpdb"
}

variable "db_root_name" {
  default = "admin"
}

variable "db_root_pass" {}

variable "db_user_name" {
  default = "wpuser"
}

variable "db_user_pass" {}

variable "db_storage_encrypted" {
  default = "false"
}

variable "db_backup_retention_period" {
  default = 7
}

variable "db_backup_window" {
  default = "15:00-15:30"
}

variable "db_maintenance_window" {
  default = "Sat:16:00-Sat:16:30"
}

variable "db_deletion_protection" {
  default = "false" #本番環境ではtrueに変更
}

variable "db_performance_insights_enabled" {
  default = "true"
}

variable "db_performance_insights_retention_period" {
  default = 7
}

variable "db_monitoring_interval" {
  default = 60
}

variable "db_auto_minor_version_upgrade" {
  default = "true"
}

variable "db_skip_final_snapshot" {
  default = "true"
}

variable "db_apply_immediately" {
  default = "true"
}

# ElastiCache #
variable "cache_multi_az_enabled" {
  default = "true"
}

variable "cache_automatic_failover_enabled" {
  default = "true"
}

variable "cache_node_type" {
  default = "cache.m6g.large"
}
variable "num_node_groups" {
  default = 2
}

variable "replicas_per_node_group" {
  default = 1
}

variable "cache_snapshot_retention_limit" {
  default = 7
}

variable "cache_snapshot_window" {
  default = "15:00-16:00"
}

variable "cache_maintenance_window" {
  default = "Sat:16:00-Sat:17:00"
}

variable "cache_auto_minor_version_upgrade" {
  default = "true"
}

variable "cache_apply_immediately" {
  default = "true"
}
