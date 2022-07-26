# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "private_1a_subnet_id" {}

variable "private_1c_subnet_id" {}

variable "associate_public_ip_address" {}

variable "security_group_id" {}

variable "public_1a_ngw_id" {}

variable "public_1c_ngw_id" {}

variable "target_group_arn" {}

variable "ecs_task_role_arn" {}

variable "ecs_exec_role_arn" {}

variable "container_definitions_file" {}

variable "ecs_cluster_arn" {}

variable "ecs_service_desired_count" {}

variable "ecs_container_name" {}

variable "ecs_container_port" {}
