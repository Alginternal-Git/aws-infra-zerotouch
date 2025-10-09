# =============================================================================
# PRODUCTION INTERNET GATEWAY - MAIN CONFIGURATION
# =============================================================================
# This configuration creates an Internet Gateway (IGW) for the production VPC.
# It enables public subnets to communicate with the internet, supporting
# load balancers, bastion hosts, and other public-facing components.
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
# DATA BLOCK - Dynamically fetch the production VPC by environment tag
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
  vpc_id      = data.aws_vpc.selected.id
  tags        = var.tags
}
