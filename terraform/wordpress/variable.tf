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

variable "bucket_policy_document_file" {
  default = "./src/bucket_policy_document.json"
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
  default = "./src/user_data_cms.tpl"
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

variable "storage_encrypted" {
  default = "false"
}

variable "backup_retention_period" {
  default = 7
}

variable "backup_window" {
  default = "15:00-15:30"
}

variable "maintenance_window" {
  default = "Sat:16:00-Sat:16:30"
}

variable "deletion_protection" {
  default = "false" #本番環境ではtrueに変更
}

variable "skip_final_snapshot" {
  default = "true"
}

variable "apply_immediately" {
  default = "true"
}

variable "instance_class" {
  default = "db.r6g.large"
}

variable "performance_insights_enabled" {
  default = "true"
}

variable "performance_insights_retention_period" {
  default = 7
}

variable "monitoring_interval" {
  default = 60
}

variable "auto_minor_version_upgrade" {
  default = "true"
}

# AutoScailing #
variable "health_check_grace_period" {
  default = 300
}

variable "desired_capacity" {
  default = 2
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "protect_from_scale_in" {
  default = "false"
}

variable "target_value" {
  default = 50
}

# Route53 #
variable "naked_domain" {}

variable "sub_domain" {}

# WAF #
variable "cloudwatch_metrics_enabled" {
  default = "true"
}

variable "sampled_requests_enabled" {
  default = "true"
}

# CloudFront #
variable "default_origin_protocol_policy" {
  default = "https-only"
}

variable "default_origin_ssl_protocols" {
  default = ["TLSv1.1", "TLSv1.2"]
}

variable "custom_header_name" {}

variable "custom_header_value" {}

variable "default_cb_allowed_methods" {
  default = ["GET", "HEAD"]
}

variable "default_cb_cached_methods" {
  default = ["GET", "HEAD"]
}
variable "default_cb_query_string" {
  default = "true"
}

variable "default_cb_cookies_forward" {
  default = "all"
}

variable "default_cb_viewer_protocol_policy" {
  default = "redirect-to-https"
}

variable "default_cb_min_ttl" {
  default = 0
}

variable "default_cb_default_ttl" {
  default = 0
}

variable "default_cb_max_ttl" {
  default = 0
}

variable "default_cb_compress" {
  default = "false"
}

variable "cf_geo_restriction_type" {
  default = "none"
}

variable "cf_enabled" {
  default = "true"
}

variable "cf_is_ipv6_enabled" {
  default = "false"
}

variable "cf_price_class" {
  default = "PriceClass_All"
}

variable "cf_log_include_cookies" {
  default = "false"
}

variable "cf_log_prefix" {
  default = "cf-log"
}

variable "cf_minimum_protocol_version" {
  default = "TLSv1.2_2019"
}

variable "cf_ssl_support_method" {
  default = "sni-only"
}
