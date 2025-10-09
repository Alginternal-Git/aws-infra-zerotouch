# =============================================================================
# DEVELOPMENT RDS - MAIN CONFIGURATION (AUTO-DISCOVERY ENABLED)
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

# -----------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# DATA BLOCKS - DYNAMIC DISCOVERY
# -----------------------------------------------------------------------------

# ✅ Automatically discover VPC by environment tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# ✅ Discover private subnets under that VPC
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

# ✅ Discover database security group
data "aws_security_group" "database" {
  filter {
    name   = "group-name"
    values = ["${var.environment}-database-sg"]
  }
}

# -----------------------------------------------------------------------------
# MODULE CALL - Pass discovered values
# -----------------------------------------------------------------------------
module "rds" {
  source = "../../../modules/rds"

  environment            = var.environment
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  parameter_group_family = var.parameter_group_family
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_encrypted      = var.storage_encrypted
  username               = var.username
  password               = var.password

  # ✅ Auto-discovered network values
  vpc_id             = data.aws_vpc.selected.id
  subnet_ids         = data.aws_subnets.private.ids
  security_group_ids = [data.aws_security_group.database.id]

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  multi_az            = false
  skip_final_snapshot = true
  publicly_accessible = false
  deletion_protection = false

  tags = var.tags
}

# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------
output "dev_rds_summary" {
  description = "Summary of development RDS configuration"
  value = {
    environment     = var.environment
    vpc_id          = data.aws_vpc.selected.id
    private_subnets = data.aws_subnets.private.ids
    db_sg_id        = data.aws_security_group.database.id
    db_engine       = var.engine
    instance_class  = var.instance_class
    backup_days     = var.backup_retention_period
  }
}
