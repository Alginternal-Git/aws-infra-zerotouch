# =============================================================================
# DEVELOPMENT RDS - CONFIGURATION VALUES
# =============================================================================

# AWS Configuration
aws_region = "us-east-1"
environment = "dev"

# Network Configuration - YOUR REAL VALUES
#vpc_id = "vpc3"  # Your vpc  id
#database_security_group_id = "sg0a18"  # Your dev database SG

# REAL Private Subnet IDs (replace with actual from AWS console)
#ubnet_ids = [
 # "subnet-014",  # dev-private-subnet-1a (us-east-1a)  
  #"subnet-06857"   # dev-private-subnet-1b (us-east-1b)
#]

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
