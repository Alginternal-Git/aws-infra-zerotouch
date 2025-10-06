resource "aws_eks_cluster" "this" {
  name     = "${var.name}-eks"
  role_arn = var.cluster_role_arn
  version  = 1.32

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_public_access = true
  }

  tags = merge(var.tags, { Name = "${var.name}-eks" })
}

# Node Group for users
resource "aws_eks_node_group" "users" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.name}-users"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.user_instance_type]
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  tags = merge(var.tags, { Role = "user" })
}

# Node Group for applications
resource "aws_eks_node_group" "apps" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.name}-apps"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.app_instance_type]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  tags = merge(var.tags, { Role = "application" })
}
