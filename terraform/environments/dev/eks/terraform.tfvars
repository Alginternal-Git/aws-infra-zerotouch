cluster_name       = "dev-demo"
vpc_id             = "vpc-0e2a73d857563b293"
subnet_ids         = ["subnet-0ed093e1e57fb5fde", "subnet-073c976d68073626e"]
node_group_name    = "dev-eks-nodes"
instance_type      = "t3.medium"
desired_capacity   = 3
min_capacity       = 1
max_capacity       = 3
# IAM ROLES CONFIGURATION
# =============================================================================
# IAM role for EKS control plane - manages Kubernetes API server
# Must be created in your AWS account with AmazonEKSClusterPolicy
# Account ID: 386930771987 (replace with your account if different)
eks_role_arn = "arn:aws:iam::386930771987:role/EKSClusterRole"

# IAM role for EKS worker nodes - allows nodes to join cluster
# Must have: AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonEC2ContainerRegistryReadOnly
node_role_arn = "arn:aws:iam::386930771987:role/EKSNodeRole"
cluster_version    = "1.32"
user_instance_type = "t3.medium"
app_instance_type  = "t3.medium"
tags = {
  Environment = "dev"
  Project     = "zero-touch"
}
