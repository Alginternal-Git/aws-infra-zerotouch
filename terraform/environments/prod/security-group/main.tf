# =============================================================================
# PRODUCTION SECURITY GROUPS - MAIN CONFIGURATION
# =============================================================================
# This creates production security groups with strict security controls:
# - SSH restricted to specific office IPs
# - Database access only from VPC/web servers
# - All traffic logged and monitored
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Require specific Terraform version for consistency
  required_version = ">= 1.5"
}

# Configure AWS provider for production region
provider "aws" {
  region = var.aws_region
  
  # Production-specific provider configuration
  default_tags {
    tags = {
      Environment = "prod"
      ManagedBy   = "terraform"
      Project     = "zero-touch"
    }
  }
}

# Create security groups using our module
module "security_groups" {
  source = "../../../modules/security-groups"
  
  # Basic configuration
  environment = var.environment  # "prod"
  vpc_id      = var.vpc_id       # Your production VPC ID
  
  # Web server access - allow HTTPS from internet, restrict SSH
  web_ingress_cidrs = var.web_ingress_cidrs  # 0.0.0.0/0 for web traffic
  ssh_ingress_cidrs = var.ssh_ingress_cidrs  # RESTRICTED to office IPs
  
  # Database access - NEVER allow from internet in production
  database_ingress_cidrs = var.database_ingress_cidrs  # VPC CIDR only  
  database_source_sgs    = var.database_source_sgs     # Web SG IDs
  
  # EKS configuration (if using Kubernetes)
  eks_control_plane_sgs = var.eks_control_plane_sgs
  
  # Production tags for compliance and cost tracking
  tags = var.tags
}
