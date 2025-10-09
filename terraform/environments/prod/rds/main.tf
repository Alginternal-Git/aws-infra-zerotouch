# =============================================================================
# PRODUCTION RDS - MAIN CONFIGURATION (FULLY DYNAMIC DISCOVERY)
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

# -----------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment         = var.environment
      Project             = "zero-touch"
      ManagedBy           = "terraform"
      Compliance          = "SOX"
      DataClassification  = "Internal"
      CreatedBy           = "infrastructure-team"
      Component           = "rds"
    }
  }
}

provider "random" {}

# -----------------------------------------------------------------------------
# DATA BLOCKS - Dynamic Discovery
# -----------------------------------------------------------------------------

# ✅ 1️⃣ Discover VPC by environment tag (e.g., "prod-vpc")
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# ✅ 2️⃣ Discover private subnets for RDS placement
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# ✅ 3️⃣ Discover database security group by naming convention
data "aws_security_group" "database" {
  filter {
    name   = "group-name"
    values = ["${var.environment}-database-sg"]
  }
}

# -----------------------------------------------------------------------------
# KMS KEY FOR RDS ENCRYPTION
# -----------------------------------------------------------------------------
resource "aws_kms_key" "rds_encryption" {
  description             = "KMS key for ${var.environment} RDS encryption"
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

# -----------------------------------------------------------------------------
# RANDOM PASSWORD (optional secure generation)
# -----------------------------------------------------------------------------
resource "random_password" "master_password" {
  count   = var.use_random_password ? 1 : 0
  length  = 32
  special = true
  override_special = "!#$%&()*+,-.:;<=>?[]^_{|}~"
}

# -----------------------------------------------------------------------------
# RDS MODULE CONFIGURATION
# -----------------------------------------------------------------------------
module "rds" {
  source = "../../../modules/rds"

  # General
  environment          = var.environment
  db_name              = var.db_name

  # Engine & Instance
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_family = var.parameter_group_family

  # Storage & Encryption
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true
  kms_key_id            = aws_kms_key.rds_encryption.arn

  # Credentials
  username = var.username
  password = var.use_random_password ? random_password.master_password[0].result : var.password

  # Network (AUTO DISCOVERED ✅)
  vpc_id             = data.aws_vpc.selected.id
  subnet_ids         = data.aws_subnets.private.ids
  security_group_ids = [data.aws_security_group.database.id]

  # Backup & Maintenance
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  # Production Hardening
  multi_az            = true
  skip_final_snapshot = true
  deletion_protection = false

  tags = var.tags
}
