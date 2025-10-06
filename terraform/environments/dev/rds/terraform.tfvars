# =============================================================================
# DEVELOPMENT RDS - CONFIGURATION VALUES
# =============================================================================

# AWS Configuration
aws_region = "us-east-1"
environment = "dev"

# Network Configuration - YOUR REAL VALUES
vpc_id = "vpc-0f13f9687b72a6e03"  # Your vpc  id
database_security_group_id = "sg-0a7a3580eee69ea18"  # Your dev database SG

# REAL Private Subnet IDs (replace with actual from AWS console)
subnet_ids = [
  "subnet-017fd88c4984940a4",  # dev-private-subnet-1a (us-east-1a)  
  "subnet-0685b4d96ea6334d7"   # dev-private-subnet-1b (us-east-1b)
]

# Database Configuration
db_name     = "devapp"
engine      = "mysql"
engine_version = "8.0"
instance_class = "db.t3.micro"  # Free tier eligible

# Storage Configuration
allocated_storage     = 20
max_allocated_storage = 50
storage_encrypted     = true

# Database Credentials
username = "admin"
password = "DevPassword123!"  # CHANGE TO SECURE PASSWORD

# Backup Configuration
backup_retention_period = 7
backup_window          = "03:00-04:00"
maintenance_window     = "sun:04:00-sun:05:00"

# Development Tags
tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "development-team"
  VPC         = "dev-algroims-vpc"
}
