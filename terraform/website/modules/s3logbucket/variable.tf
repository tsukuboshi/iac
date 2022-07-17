# ====================
#
# Variables
#
# ====================

variable "system" {}

variable "project" {}

variable "environment" {}

variable "resourcetype" {}

variable "internal" {}

variable "object_ownership" {}

variable "object_expiration_days" {}

variable "bucket_policy_document_file" {
  default = "./src/bucket_policy_document.json"
}
