# =============================================================================
# PRODUCTION EC2 MAIN CONFIGURATION
# =============================================================================
# This configuration dynamically discovers existing networking and security
# resources in the Production VPC, and launches:
#   1. A Bastion Host in public subnet (with Elastic IP)
#   2. Application Servers in private subnets
# using reusable module "../../../modules/ec2"
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

  default_tags {
    tags = var.tags
  }
}

# -----------------------------------------------------------------------------
# FETCH EXISTING VPC
# -----------------------------------------------------------------------------
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# FETCH PUBLIC AND PRIVATE SUBNETS
# -----------------------------------------------------------------------------
data "aws_subnets" "public" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# -----------------------------------------------------------------------------
# FETCH SECURITY GROUPS DYNAMICALLY (NO HARDCODED IDS)
# -----------------------------------------------------------------------------

# Bastion Host SG (SSH access)
data "aws_security_group" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-bastion-sg"]
  }
  vpc_id = data.aws_vpc.selected.id
}

# Application Servers SG (private layer)
data "aws_security_group" "app_servers" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-app-servers-sg"]
  }
  vpc_id = data.aws_vpc.selected.id
}

# -----------------------------------------------------------------------------
# MODULE CALL - EC2 (PRODUCTION CONFIGURATION)
# -----------------------------------------------------------------------------
module "ec2" {
  source = "../../../modules/ec2"

  environment                = var.environment
  vpc_id                     = data.aws_vpc.selected.id
  key_name                   = var.key_name
  public_subnet_ids          = data.aws_subnets.public.ids
  private_subnet_ids         = data.aws_subnets.private.ids
  bastion_security_group_ids = [data.aws_security_group.bastion.id]
  app_security_group_ids     = [data.aws_security_group.app_servers.id]
  tags                       = var.tags
}

