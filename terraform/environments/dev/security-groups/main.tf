# =============================================================================
# DEVELOPMENT SECURITY GROUPS - MAIN CONFIGURATION (Dynamic Version)
# =============================================================================
# Development environment with relaxed security settings for easier testing
# and development workflows. VPC is dynamically fetched based on environment.
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
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region

  # Development-specific tagging (auto-applied to all resources)
  default_tags {
    tags = {
      Environment  = "dev"
      ManagedBy    = "terraform"
      Project      = "zero-touch"
      AutoShutdown = "enabled"  # Dev resources can be auto-stopped
    }
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCK - Fetch VPC dynamically by environment tag
# -----------------------------------------------------------------------------
# Instead of hardcoding vpc_id, this automatically finds the VPC tagged 
# Name = "dev-vpc". It ensures this config is portable across environments.
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# -----------------------------------------------------------------------------
# SECURITY GROUPS MODULE
# -----------------------------------------------------------------------------
# Creates all security groups dynamically inside the selected VPC.
# Includes:
# - Web SG
# - Database SG
# - Load Balancer SG
# - EKS SG
# - Bastion SG (optional)
# - Application Server SG (optional)
# -----------------------------------------------------------------------------
module "security_groups" {
  source = "../../../modules/security-groups"

  # Basic configuration
  environment = var.environment
  vpc_id      = data.aws_vpc.selected.id  # ✅ Dynamic (no hardcoding)

  # Web server and SSH access
  web_ingress_cidrs = var.web_ingress_cidrs
  ssh_ingress_cidrs = var.ssh_ingress_cidrs

  # Database access
  database_ingress_cidrs = var.database_ingress_cidrs
  database_source_sgs    = var.database_source_sgs

  # EKS communication (if testing Kubernetes in dev)
  eks_control_plane_sgs = var.eks_control_plane_sgs

  # Bastion and App SG creation flags
  create_bastion_sg = var.create_bastion_sg
  create_app_sg     = var.create_app_sg
  bastion_allowed_cidrs = var.bastion_allowed_cidrs
  app_ports             = var.app_ports

  # Tags for all SGs
  tags = var.tags
}
