# =============================================================================
# SUBNETS MODULE - DEVELOPMENT ENVIRONMENT
# =============================================================================
# This configuration dynamically fetches the VPC and Internet Gateway (IGW)
# using data blocks based on environment tags. It then provisions public and
# private subnets inside that VPC using the subnets module.
#
# Author: Prathyusha Y
# Environment: Development (dev)
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# -----------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region
}

# -----------------------------------------------------------------------------
# DATA BLOCK - Fetch VPC dynamically by environment tag
# -----------------------------------------------------------------------------
# This ensures the subnets are always created inside the correct VPC
# (Example: dev-vpc, prod-vpc)
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCK - Fetch Internet Gateway dynamically by environment tag
# -----------------------------------------------------------------------------
# This ensures that public subnets can route traffic through the correct IGW
data "aws_internet_gateway" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-igw"]
  }

  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# -----------------------------------------------------------------------------
# MODULE CALL - SUBNETS
# -----------------------------------------------------------------------------
# This calls the reusable subnets module which:
# - Creates public and private subnets
# - Associates route tables
# - Connects to the IGW for public subnets
# -----------------------------------------------------------------------------
module "subnets" {
  source = "../../../modules/subnets"
  
  # Environment-specific parameters
  environment           = var.environment
  vpc_id                = data.aws_vpc.selected.id
  
  # Public/Private subnet configuration
  create_public_subnets = var.create_public_subnets
  internet_gateway_id   = data.aws_internet_gateway.selected.id
  
  public_subnets        = var.public_subnets
  private_subnets       = var.private_subnets

  # Tagging for cost management and environment clarity
  tags = var.tags
}
