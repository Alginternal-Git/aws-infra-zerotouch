# =============================================================================
# PRODUCTION SECURITY GROUPS - MAIN CONFIGURATION
# =============================================================================
# This configuration defines production-ready security groups with stricter
# access controls, limited SSH access, and enhanced monitoring tags.
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

# -----------------------------------------------------------------------------
# AWS Provider Configuration
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region

  # Enforce production-level tagging
  default_tags {
    tags = {
      Environment   = "prod"
      ManagedBy     = "terraform"
      Project       = "zero-touch"
      Compliance    = "enabled"
      Backup        = "daily"
      HighAvailability = "true"
    }
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCK - Fetch Production VPC dynamically using tag
# -----------------------------------------------------------------------------
# This ensures that the VPC is not hardcoded and is resolved by the Name tag
# Example: If environment = "prod", it searches for Name = "prod-vpc"
# -----------------------------------------------------------------------------
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# SECURITY GROUP MODULE - PRODUCTION
# -----------------------------------------------------------------------------
# Uses centralized security-groups module to create:
# - Bastion SG
# - App servers SG
# - Web SG
# - Database SG
# - Load Balancer SG
# - EKS Nodes SG (if applicable)
# -----------------------------------------------------------------------------

module "security_groups" {
  source = "../../../modules/security-groups"

  # Environment & VPC
  environment = var.environment
  vpc_id      = data.aws_vpc.selected.id

  # Access Configurations
  web_ingress_cidrs      = var.web_ingress_cidrs
  ssh_ingress_cidrs      = var.ssh_ingress_cidrs
  database_ingress_cidrs = var.database_ingress_cidrs
  database_source_sgs    = var.database_source_sgs
  eks_control_plane_sgs  = var.eks_control_plane_sgs

  # Optional Security Groups
  create_bastion_sg      = var.create_bastion_sg
  create_app_sg          = var.create_app_sg
  bastion_allowed_cidrs  = var.bastion_allowed_cidrs
  app_ports              = var.app_ports

  # Tags
  tags = var.tags
}

# -----------------------------------------------------------------------------
# OUTPUTS - Summary for Audit and Reference
# -----------------------------------------------------------------------------
# These outputs are useful for referencing in EC2 or RDS modules
# -----------------------------------------------------------------------------

