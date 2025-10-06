# =============================================================================
# DEVELOPMENT NAT GATEWAY - CONFIGURATION VALUES
# =============================================================================

# AWS Configuration
aws_region = "us-east-1"
environment = "dev"

# Network Configuration - YOUR ACTUAL DEV VPC
vpc_id = "vpc-0f13f9687b72a6e03"  # Your dev-algroims-vpc

# Development Cost Optimization
single_nat_gateway = true  # Single NAT Gateway for cost savings

# Development Tags
tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "development-team"
  CostCenter  = "development"
}
