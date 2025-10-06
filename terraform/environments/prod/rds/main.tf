# =============================================================================
# PRODUCTION RDS - MAIN CONFIGURATION (ENTERPRISE GRADE)
# =============================================================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Provider Configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment            = var.environment
      Project               = "zero-touch"
      ManagedBy             = "terraform"
      Compliance            = "SOX"
      DataClassification    = "Internal"
      CreatedBy             = "infrastructure-team"
      Component             = "rds"
    }
  }
}

provider "random" {}

# KMS Key for Production Database Encryption
resource "aws_kms_key" "rds_encryption" {
  description             = "KMS key for production RDS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name    = "${var.environment}-rds-kms-key"
    Purpose = "RDS Encryption"
  })
}

resource "aws_kms_alias" "rds_encryption" {
  name          = "alias/${var.environment}-rds-encryption-key"
  target_key_id = aws_kms_key.rds_encryption.key_id
}

# Random password for additional security
resource "random_password" "master_password" {
  count   = var.use_random_password ? 1 : 0
  length  = 32
  special = true
  override_special = "!#$%&()*+,-.:;<=>?[]^_{|}~" # Exclude '/', '@', '"', and space
}

# RDS Database Module (Production Configuration)
module "rds" {
source = "../../../modules/rds"

  environment = var.environment
  db_name     = var.db_name

  # Database Configuration
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_family = var.parameter_group_family

  # Storage Configuration - Production Grade
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type         = "gp3"
  storage_encrypted    = true

  # Credentials
  username = var.username
  password = var.use_random_password ? random_password.master_password[0].result : var.password

  # Network Configuration - USING YOUR SPECIFIC PRODUCTION SUBNETS
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.database_security_group_id]

  # Backup Configuration - Production Requirements
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # Production specific settings
  multi_az               = true   # High Availability - REQUIRED
  skip_final_snapshot    = false  # Keep final snapshots
  publicly_accessible    = false

  tags = var.tags
}
