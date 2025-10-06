# =============================================================================
# PRODUCTION SECURITY GROUPS - CRITICAL DIFFERENCES
# =============================================================================
aws_region  = "us-west-2"    # ← Different region
environment = "prod"          # ← Production environment

# PRODUCTION VPC (MUST CHANGE)
vpc_id = "vpc-094620e7f146a180b"  # ← Your actual PROD VPC ID

# Web Access - same as dev
web_ingress_cidrs = ["0.0.0.0/0"]

# SSH Access - RESTRICTED in production
ssh_ingress_cidrs = [
  "203.0.113.0/24",    # ← Your office IP range
  "198.51.100.0/24"    # ← Your VPN IP range  
]

# Database Access - VPC only
database_ingress_cidrs = ["10.0.0.0/16"]  # ← Your PROD VPC CIDR

# Production Tags - compliance required
tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  Compliance  = "SOX"
  Backup      = "Required"
  Monitoring  = "Required"
  CreatedBy   = "Terraform"
}
