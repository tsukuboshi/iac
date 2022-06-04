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
      version = "~> 4.0"
    }
  }
}

# ====================
#
# Provider
#
# ====================

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Prj = var.project
      Env = var.environment
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  default_tags {
    tags = {
      Prj = var.project
      Env = var.environment
    }
  }
}
