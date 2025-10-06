# =============================================================================
# PRODUCTION NAT GATEWAY - MAIN CONFIGURATION (ENTERPRISE GRADE)
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
      Environment            = var.environment
      Project               = "zero-touch"
      ManagedBy             = "terraform"
      Component             = "nat-gateway"
      Compliance            = "SOX"
      DataClassification    = "Internal"
      Support               = "24x7"
      Criticality           = "High"
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

# NAT Gateway Module - PRODUCTION MULTI-AZ CONFIGURATION
module "nat_gateway" {
  source = "../../../../modules/nat-gateway"

  environment          = var.environment
  vpc_id              = var.vpc_id
  internet_gateway_id = data.aws_internet_gateway.main.id
  
  # Production High Availability Configuration
  create_nat_gateways = true
  # Do not pass single_nat_gateway or tags if not supported by module
}
