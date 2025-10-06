# =============================================================================
# DEVELOPMENT NAT GATEWAY - MAIN CONFIGURATION (CORRECTED)
# =============================================================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "zero-touch"
      ManagedBy   = "terraform"
      Component   = "nat-gateway"
    }
  }
}

# Get VPC information
data "aws_vpc" "main" {
  id = var.vpc_id
}

# Get Internet Gateway information
data "aws_internet_gateway" "main" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

# NAT Gateway Module - CORRECTED ARGUMENTS
module "nat_gateway" {
  source = "../../../modules/nat-gateway"

  # Only pass variables that exist in the module
  environment          = var.environment
  vpc_id              = var.vpc_id
  internet_gateway_id = data.aws_internet_gateway.main.id
  create_nat_gateways = true
  
  # Remove single_nat_gateway and tags - they don't exist in module
  # single_nat_gateway = var.single_nat_gateway  ← REMOVE THIS
  # tags = var.tags                               ← REMOVE THIS
}
