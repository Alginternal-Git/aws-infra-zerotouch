# =============================================================================
# DEVELOPMENT NAT GATEWAY - CONFIGURATION VALUES (FINAL)
# =============================================================================

aws_region  = "us-east-1"
environment = "dev"

# Development cost optimization (single NAT Gateway)
single_nat_gateway = true

tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "Development-Team"
  CostCenter  = "Development"
}
