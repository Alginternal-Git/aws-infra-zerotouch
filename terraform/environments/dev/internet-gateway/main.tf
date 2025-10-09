# =============================================================================
# DEVELOPMENT INTERNET GATEWAY - MAIN CONFIGURATION
# =============================================================================
# This configuration creates an Internet Gateway (IGW) and attaches it to
# the development VPC. It allows resources in public subnets to access
# the internet and receive traffic from it.
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# -----------------------------------------------------------------------------
# DATA BLOCKS - Fetch the VPC dynamically by environment tag
# -----------------------------------------------------------------------------
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# MODULE CALL - Internet Gateway
# -----------------------------------------------------------------------------
module "internet_gateway" {
  source = "../../../modules/internet-gateway"

  environment = var.environment
  vpc_id      = data.aws_vpc.selected.id  # dynamically fetched VPC ID
  tags        = var.tags
}
