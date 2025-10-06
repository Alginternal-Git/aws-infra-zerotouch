terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "eks" {
  source = "../../../modules/eks"

  cluster_name       = var.cluster_name
  name               = var.cluster_name
  cluster_version    = var.cluster_version

  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids

  node_group_name    = var.node_group_name
  instance_type      = var.instance_type
  desired_capacity   = var.desired_capacity
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity

  eks_role_arn       = var.eks_role_arn
  cluster_role_arn   = var.eks_role_arn
  node_role_arn      = var.node_role_arn

  user_instance_type = var.user_instance_type
  app_instance_type  = var.app_instance_type

  tags               = var.tags
}
