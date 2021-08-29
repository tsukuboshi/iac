# ====================
#
# Terraform
#
# ====================

terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# ====================
#
# Provider
#
# ====================

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
