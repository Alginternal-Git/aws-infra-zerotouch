# =============================================================================
# PRODUCTION RDS - CONFIGURATION VALUES 
# =============================================================================

# AWS Configuration
aws_region = "us-west-2"
environment = "prod"

# Network Configuration - YOUR REAL PRODUCTION VALUES
vpc_id = "vpc-094620e7f146a180b"  # Your prod-vpc from 
database_security_group_id = "sg-0c9bf0cb7d4f6c099"  # Your prod database SG ID

# REAL Production Private Subnet IDs (from your screenshot)
subnet_ids = [
  "subnet-003380f7fc18b1512",  # prod-private-subnet-2a (us-west-2a)
  "subnet-07979d1970af9dd13",   # prod-private-subnet-2b (us-west-2b)
  "subnet-0a45cb11cc3b0bad8"    # prod-private-subnet-2c (us-west-2c)
]

# Database Configuration - Production Specifications
db_name     = "prodapp"
engine      = "mysql"
engine_version = "8.0"  # MySQL version for AWS RDS (must be a version supported in your AWS region)
# NOTE:
# - Only specify MySQL versions that are available for Amazon RDS in your chosen AWS region.
# - If you use an unsupported version, Terraform will fail with an InvalidParameterCombination error.
# - Check the AWS Console or documentation for the latest supported MySQL versions before updating this value.
instance_class = "db.t3.micro"  # Free Tier eligible (1GB RAM, burstable)
# NOTE:
# - db.t3.micro is Free Tier eligible and suitable for development, testing, or small production workloads.
# - db.t3.small (and larger) are NOT Free Tier eligible and will incur charges even on Free Tier accounts.
# - If you need more resources, you can upgrade to db.t3.small or larger, but be aware of AWS billing.
# - Always verify Free Tier eligibility and instance pricing in the AWS documentation before changing this value.

# Storage Configuration - Production Scale
allocated_storage     = 100   # 100GB initial storage
max_allocated_storage = 1000  # Auto-scale up to 1TB

# Database Credentials - PRODUCTION SECURITY
username = "prodadmin"
use_random_password = true  # Use randomly generated secure password
# password = ""  # Leave empty when using random password

# Alternative: If you want to set a specific password, disable random password
# use_random_password = false
# password = "YourSuperSecureProductionPassword2024!"  # 16+ characters required

# Backup Configuration - Production Compliance Requirements
backup_retention_period = 30    # 30 days for compliance (SOX, GDPR)
backup_window          = "03:00-04:00"    # 3-4 AM UTC (low traffic period)
maintenance_window     = "sun:04:00-sun:05:00"  # Sunday 4-5 AM UTC

# Production Compliance Tags (REQUIRED)
tags = {
  Environment            = "prod"
  Project               = "zero-touch"
  ManagedBy             = "terraform"
  
  # Compliance & Security
  Compliance            = "SOX"
  DataClassification    = "Internal"
  SecurityReview        = "Approved"
  EncryptionRequired    = "Yes"
  
  # Operations
  Backup                = "Required"
  BackupRetention       = "30-days"
  Monitoring            = "Required"
  Support               = "24x7"
  Criticality           = "High"
  
  # Maintenance
  MaintenanceWindow     = "Sunday-04:00-05:00-UTC"
  MaintenanceContact    = "production-team@company.com"
  
  # Financial
  CostCenter            = "production"
  BusinessUnit          = "engineering"
  Owner                 = "production-team"
  
  # Governance
  CreatedDate           = "2025-09-29"
  ReviewDate            = "2026-09-29"
  ApprovedBy            = "infrastructure-team"
  VPC                   = "prod-vpc"
}
