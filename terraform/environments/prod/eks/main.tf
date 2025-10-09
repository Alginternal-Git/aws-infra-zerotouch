# =============================================================================
# PRODUCTION EKS - MAIN CONFIGURATION (FULLY DYNAMIC)
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
      Component   = "eks"
      Compliance  = "SOX"
      Owner       = "infrastructure-team"
    }
  }
}

# -----------------------------------------------------------------------------
# DATA BLOCKS - DYNAMIC DISCOVERY
# -----------------------------------------------------------------------------

#  Discover VPC dynamically by tag name (e.g., "prod-vpc")
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

#  Discover private subnets dynamically within the VPC
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

#  Discover IAM roles for EKS (already created in IAM console)
data "aws_iam_role" "eks_cluster_role" {
  name = "EKSClusterRole"
}

data "aws_iam_role" "eks_node_role" {
  name = "EKSNodeRole"
}

# -----------------------------------------------------------------------------
# EKS MODULE CONFIGURATION
# -----------------------------------------------------------------------------
module "eks" {
  source = "../../../modules/eks"

  # Cluster configuration
  name              = var.cluster_name
  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version

  # Networking (auto-discovered)
  vpc_id            = data.aws_vpc.selected.id
  subnet_ids        = data.aws_subnets.private.ids

  # Node group configuration
  node_group_name   = var.node_group_name
  instance_type     = var.instance_type
  desired_capacity  = var.desired_capacity
  min_capacity      = var.min_capacity
  max_capacity      = var.max_capacity

  # IAM Roles (auto-discovered)
  eks_role_arn       = data.aws_iam_role.eks_cluster_role.arn
  cluster_role_arn   = data.aws_iam_role.eks_cluster_role.arn
  node_role_arn      = data.aws_iam_role.eks_node_role.arn

  # Optional workload node types
  user_instance_type = var.user_instance_type
  app_instance_type  = var.app_instance_type

  tags = var.tags
}

