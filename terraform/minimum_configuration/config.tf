# ====================
#
# Provider
#
# ====================

provider "aws" {

  region  = var.aws_region
  profile = var.aws_profile

}

# ====================
#
# Terraform
#
# ====================

terraform {

  required_version = "1.0.0"

}
