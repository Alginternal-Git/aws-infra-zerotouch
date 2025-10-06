# =============================================================================
# DEVELOPMENT RDS - MAIN CONFIGURATION
# =============================================================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "zero-touch"
      ManagedBy   = "terraform"
      Component   = "rds"
    }
  }
}

# RDS Database Module
module "rds" {
source = "../../../modules/rds"
  environment = var.environment
  db_name     = var.db_name

  # Database Configuration
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_family = var.parameter_group_family

  # Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted

  # Credentials
  username = var.username
  password = var.password

  # Network Configuration - USING YOUR SPECIFIC SUBNETS
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.database_security_group_id]

  # Backup Configuration
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # Development specific settings
  multi_az               = false  # Single AZ for cost savings
  skip_final_snapshot    = true   # Skip final snapshot in dev
  publicly_accessible    = false

  tags = var.tags
}
