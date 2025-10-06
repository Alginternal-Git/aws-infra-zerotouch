# =============================================================================
# DEVELOPMENT SECURITY GROUPS - CONFIGURATION VALUES
# =============================================================================
aws_region  = "us-east-1"
environment = "dev"

# VPC Configuration - CHANGE THIS TO YOUR ACTUAL DEV VPC ID
vpc_id = "vpc-0f13f9687b72a6e03"  # Replace with your VPC ID

# Web Access Configuration
web_ingress_cidrs = ["0.0.0.0/0"]

# SSH Access Configuration - MORE PERMISSIVE IN DEV
ssh_ingress_cidrs = [
  "0.0.0.0/0"
]

# Database Access Configuration
database_ingress_cidrs = [
  "10.0.0.0/16"  # Change to your dev VPC CIDR
]

# Database access from specific security groups
database_source_sgs = []

# EKS Configuration
eks_control_plane_sgs = []

# Development Tags - FIXED VERSION
tags = {
  Environment   = "dev"
  Project       = "zero-touch"
  Region        = "us-east-1"
  Service       = "security-groups"
  CostCenter    = "Development"
  Owner         = "DevOps-Team"
  AutoShutdown  = "Enabled"      # ← FIXED: Added missing value
  Backup        = "NotRequired"
  Monitoring    = "Basic"
  Purpose       = "Testing"
  CreatedBy     = "Terraform"
} 
 # ← FIXED: Added missing closing bracket
