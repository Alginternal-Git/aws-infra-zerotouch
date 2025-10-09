# Discover VPC
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

# Discover Subnets
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

# Discover IAM Roles
data "aws_iam_role" "eks_cluster_role" {
  name = "EKSClusterRole"
}

data "aws_iam_role" "eks_node_role" {
  name = "EKSNodeRole"
}

# Module Call
module "eks" {
  source = "../../../modules/eks"

  name              = var.cluster_name
  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version

  vpc_id            = data.aws_vpc.selected.id
  subnet_ids        = data.aws_subnets.private.ids

  eks_role_arn      = data.aws_iam_role.eks_cluster_role.arn
  cluster_role_arn  = data.aws_iam_role.eks_cluster_role.arn
  node_role_arn     = data.aws_iam_role.eks_node_role.arn

  node_group_name   = var.node_group_name
  instance_type     = var.instance_type
  desired_capacity  = var.desired_capacity
  min_capacity      = var.min_capacity
  max_capacity      = var.max_capacity

  user_instance_type = var.user_instance_type
  app_instance_type  = var.app_instance_type

  tags = var.tags
}
