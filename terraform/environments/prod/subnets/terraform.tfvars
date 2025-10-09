# =============================================================================
# TERRAFORM VARIABLES - SUBNETS MODULE (PRODUCTION ENVIRONMENT)
# =============================================================================

aws_region  = "us-west-2"
environment = "prod"

# -----------------------------------------------------------------------------
# Subnet Configuration
# -----------------------------------------------------------------------------
create_public_subnets = true

public_subnets = {
  "subnet-2a" = {
    cidr = "10.1.1.0/24"
    az   = "us-west-2a"
  }
  "subnet-2b" = {
    cidr = "10.1.2.0/24"
    az   = "us-west-2b"
  }
  "subnet-2c" = {
    cidr = "10.1.3.0/24"
    az   = "us-west-2c"
  }
}

private_subnets = {
  "subnet-2a" = {
    cidr = "10.1.10.0/24"
    az   = "us-west-2a"
  }
  "subnet-2b" = {
    cidr = "10.1.20.0/24"
    az   = "us-west-2b"
  }
  "subnet-2c" = {
    cidr = "10.1.30.0/24"
    az   = "us-west-2c"
  }
}

# -----------------------------------------------------------------------------
# Tags for Cost Tracking & Management
# -----------------------------------------------------------------------------
tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
