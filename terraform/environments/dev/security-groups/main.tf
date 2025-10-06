# =============================================================================
# DEVELOPMENT SECURITY GROUPS - MAIN CONFIGURATION
# =============================================================================
# Development environment with relaxed security settings for easier testing
# and development workflows. Some security restrictions are loosened to allow
# developers to work more efficiently while still maintaining basic security.
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Allow more flexibility in Terraform versions for dev
  required_version = ">= 1.0"
}

# Configure AWS provider for development region
provider "aws" {
  region = var.aws_region
  
  # Development-specific provider configuration
  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
      Project     = "zero-touch"
      AutoShutdown = "enabled"  # Dev resources can be auto-stopped
    }
  }
}

# Create security groups using our module
module "security_groups" {
  source = "../../../modules/security-groups"
  
  # Basic configuration
  environment = var.environment  # "dev"
  vpc_id      = var.vpc_id       # Your development VPC ID
  
  # Web server access - allow from internet, SSH more permissive in dev
  web_ingress_cidrs = var.web_ingress_cidrs  # 0.0.0.0/0 for web traffic
  ssh_ingress_cidrs = var.ssh_ingress_cidrs  # More permissive in dev
  
  # Database access - allow from VPC for dev testing
  database_ingress_cidrs = var.database_ingress_cidrs  # VPC CIDR
  database_source_sgs    = var.database_source_sgs     # Web SG IDs
  
  # EKS configuration (if testing Kubernetes in dev)
  eks_control_plane_sgs = var.eks_control_plane_sgs
  
  # Development tags
  tags = var.tags
}
