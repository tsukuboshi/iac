# ====================
#
# Variables
#
# ====================


variable "aws_region" {
  default = "ap-northeast-1"
}

variable "availability_zone_1a" {
  default = "ap-northeast-1a"
}

variable "availability_zone_1c" {
  default = "ap-northeast-1c"
}

variable "az_short_name_1a" {
  default = "1a"
}

variable "az_short_name_1c" {
  default = "1c"
}

variable "system" {
  default = "example"
}

variable "project" {
  default = "website"
}

variable "environment" {
  default = "test"
}

variable "internal" {
  default = true
}

variable "naked_domain" {
  # default = "example.com"
}

variable "sub_domain" {
  default = "cm"
}

variable "service_rsrc_type_alb" {
  default = "alb"
}

variable "service_rsrc_type_ec2" {
  default = "ec2"
}

variable "service_rsrc_type_ecs" {
  default = "ecs"
}

variable "service_rsrc_type_rds" {
  default = "rds"
}

variable "service_rsrc_type_cache" {
  default = "cache"
}

variable "service_rsrc_type_backup" {
  default = "backup"
}

# VPC #
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "flow_log_file_format_text" {
  default = "plain-text"
}

variable "flow_log_file_parquet" {
  default = "parquet"
}

# Subnet #
variable "public_subnet_1a_cidr_block" {
  default = "10.0.0.0/24"
}

variable "public_subnet_1c_cidr_block" {
  default = "10.0.1.0/24"
}

variable "private_subnet_1a_cidr_block" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1c_cidr_block" {
  default = "10.0.3.0/24"
}

variable "isolated_subnet_1a_cidr_block" {
  default = "10.0.4.0/24"
}

variable "isolated_subnet_1c_cidr_block" {
  default = "10.0.5.0/24"
}

variable "network_rsrc_type_public" {
  default = "public"
}

variable "network_rsrc_type_private" {
  default = "private"
}

variable "network_rsrc_type_isolated" {
  default = "isolated"
}

# ALB #

variable "access_log_prefix" {
  default = "alb"
}

variable "alb_target_type_ec2" {
  default = "instance"
}

variable "alb_target_type_ecs" {
  default = "ip"
}

variable "alb_tg_rsrc_type_enduser" {
  default = "enduser"
}

# EC2 #
variable "instance_type" {
  default = "t3.micro"
}

variable "ebs_volume_size" {
  default = 8
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_encrypted" {
  default = false
}

variable "user_data_file" {
  default = "../../src/user_data_am.tpl"
}

variable "instance_rsrc_type_web" {
  default = "web"
}

# S3 #
variable "s3_rsrc_type_vpc" {
  default = "vpc"
}

variable "s3_rsrc_type_alb" {
  default = "alb"
}

variable "enabled_s3_acl" {
  default = "ObjectWriter"
}

variable "disabled_s3_acl" {
  default = "BucketOwnerEnforced"
}

variable "object_expiration_days" {
  default = 366
}

# Autoscailing #
variable "asg_desired_capacity" {
  default = 2
}

variable "asg_min_size" {
  default = 0
}

variable "asg_max_size" {
  default = 4
}

# ECS #
variable "container_definitions_httpd_file" {
  default = "../../src/container_definitions_httpd.json"
}

variable "ecs_httpd_service_desired_count" {
  default = 2
}

# RDS #
variable "db_instance_count" {
  default = 1
}

variable "rds_engine_version" {
  default = "8.0.20"
}

variable "aurora_engine_version" {
  default = "8.0.mysql_aurora.3.01.0"
}

variable "db_instance_class" {
  default = "db.r6g.large"
}

variable "db_root_name" {
  default = "admin"
}

variable "db_root_pass" {
  # default = "password"
}

variable "db_storage_type" {
  default = "gp2"
}

variable "db_allocated_storage" {
  default = 100
}

variable "db_max_allocated_storage" {
  default = 1000
}

variable "db_storage_encrypted" {
  default = true
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

variable "cache_engine_version" {
  default = "6.2"
}

variable "cache_node_type" {
  default = "cache.m6g.large"
}
variable "num_node_groups" {
  default = 1
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
