# ====================
#
# Variables
#
# ====================

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "system" {
  default = "example"
}

variable "project" {
  default = "scd"
}

variable "environment" {
  default = "test"
}

variable "naked_domain" {
  default = "jagabard.ml"
}

variable "sub_domain" {
  default = "scd"
}

variable "src_dir" {
  default = "../../src"
}

variable "internal" {
  default = true
}

# CloudFront #
variable "default_origin_protocol_policy" {
  default = "redirect-to-https"
}

variable "default_origin_ssl_protocols" {
  default = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "default_cb_allowed_methods" {
  default = ["GET", "HEAD"]
}

variable "default_cb_cached_methods" {
  default = ["GET", "HEAD"]
}

variable "default_cb_viewer_protocol_policy" {
  default = "redirect-to-https"
}

variable "default_cb_compress" {
  default = "true"
}

variable "cf_log_include_cookies" {
  default = "false"
}

variable "cf_log_prefix" {
  default = "cloudfront"
}

# CloudFront Functions #
variable "function_file" {
  default = "basic_auth.js"
}

variable "basicauth_pass" {
  default = "password"
}

# S3 #
variable "object_expiration_days" {
  default = 366
}

variable "object_file" {
  default = "index.html"
}
