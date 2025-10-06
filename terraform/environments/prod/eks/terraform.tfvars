aws_region         = "us-west-2"
cluster_name       = "pega-prod"
vpc_id             = "vpc-094620e7f146a180b"  # Your prod VPC ID

# Use ALL subnet IDs (both public + private) - EKS needs both
subnet_ids         = [
  "subnet-084a8b36a74e70baf",  # Public subnet 2a
  "subnet-06772ecc8ea0c78c3",  # Public subnet 2b  
  "subnet-0e54d4261c9951587",  # Public subnet 2c
  "subnet-003380f7fc18b1512",  # Private subnet 2a
  "subnet-07979d1970af9dd13",  # Private subnet 2b
  "subnet-0a45cb11cc3b0bad8"   # Private subnet 2c
]

node_group_name    = "prod-eks-nodes"
instance_type = "t3.micro" #for t3.large getting error - not in free tier for my account ( you can try diff instance types)
desired_capacity   = 5
min_capacity       = 2
max_capacity       = 10
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
user_instance_type = "t3.large"
app_instance_type  = "t3.large"

tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
