# =============================================================================
# TERRAFORM VARIABLES - SUBNETS MODULE (DEV ENVIRONMENT)
# =============================================================================

aws_region  = "us-east-1"
environment = "dev"

# -----------------------------------------------------------------------------
# Subnet Configuration
# -----------------------------------------------------------------------------
create_public_subnets = true

public_subnets = {
  "subnet-1a" = {
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
  }
  "subnet-1b" = {
    cidr = "10.0.2.0/24"
    az   = "us-east-1b"
  }
}

private_subnets = {
  "subnet-1a" = {
    cidr = "10.0.10.0/24"
    az   = "us-east-1a"
  }
  "subnet-1b" = {
    cidr = "10.0.20.0/24"
    az   = "us-east-1b"
  }
}

# -----------------------------------------------------------------------------
# Tags for cost tracking and identification
# -----------------------------------------------------------------------------
tags = {
  Environment = "dev"
  Project     = "aws-zero-touch"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
