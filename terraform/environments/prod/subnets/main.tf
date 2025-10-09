# =============================================================================
# SUBNETS MODULE - PRODUCTION ENVIRONMENT
# =============================================================================
# Dynamically fetches the VPC and Internet Gateway (IGW) using environment tags
# and provisions public and private subnets inside the production VPC.
#
# Author: Prathyusha Y
# Environment: Production (prod)
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
# Finds the VPC tagged "prod-vpc"
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCK - Fetch Internet Gateway dynamically by environment tag
# -----------------------------------------------------------------------------
# Finds the IGW tagged "prod-igw" and linked to the correct VPC
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
# Provisions production public and private subnets and associates route tables
# -----------------------------------------------------------------------------
module "subnets" {
  source = "../../../modules/subnets"
  
  # Environment-specific parameters
  environment           = var.environment
  vpc_id                = data.aws_vpc.selected.id  # ✅ dynamic lookup
  
  # Public/Private subnet configuration
  create_public_subnets = var.create_public_subnets
  internet_gateway_id   = data.aws_internet_gateway.selected.id  # ✅ dynamic lookup
  
  public_subnets        = var.public_subnets
  private_subnets       = var.private_subnets

  # Tagging for cost and environment tracking
  tags = var.tags
}
