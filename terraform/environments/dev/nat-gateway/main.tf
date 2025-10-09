# =============================================================================
# DEVELOPMENT NAT GATEWAY - MAIN CONFIGURATION (FINALIZED)
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

# -----------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# DATA BLOCK - DYNAMICALLY FETCH EXISTING VPC AND IGW
# -----------------------------------------------------------------------------
# This removes the need to hardcode IDs in tfvars
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

data "aws_internet_gateway" "selected" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# -----------------------------------------------------------------------------
# MODULE - NAT GATEWAY (DEVELOPMENT FRIENDLY)
# -----------------------------------------------------------------------------
# Creates a single NAT Gateway (cost-optimized)
module "nat_gateway" {
  source = "../../../modules/nat-gateway"

  environment          = var.environment
  vpc_id               = data.aws_vpc.selected.id
  internet_gateway_id  = data.aws_internet_gateway.selected.id
  create_nat_gateways  = true
}

# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------
output "nat_gateway_summary" {
  description = "Summary of NAT Gateway resources"
  value = {
    environment = var.environment
    vpc_id      = data.aws_vpc.selected.id
    igw_id      = data.aws_internet_gateway.selected.id
  }
}
