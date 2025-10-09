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

# -----------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment         = var.environment
      Project             = "zero-touch"
      ManagedBy           = "terraform"
      Component           = "nat-gateway"
      Compliance          = "SOX"
      DataClassification  = "Internal"
      Support             = "24x7"
      Criticality         = "High"
    }
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCKS — FETCH EXISTING VPC AND IGW DYNAMICALLY
# -----------------------------------------------------------------------------
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
# MODULE — NAT GATEWAY (MULTI-AZ HIGH AVAILABILITY)
# -----------------------------------------------------------------------------
module "nat_gateway" {
  source = "../../../modules/nat-gateway"
  environment          = var.environment
  vpc_id               = data.aws_vpc.selected.id
  internet_gateway_id  = data.aws_internet_gateway.selected.id
  create_nat_gateways  = true
}
