# =============================================================================
# PRODUCTION EKS - CONFIGURATION VALUES (DYNAMIC DISCOVERY)
# =============================================================================

aws_region      = "us-west-2"
environment     = "prod"
cluster_name    = "pega-prod"
cluster_version = "1.32"

# Node Group Configuration
node_group_name  = "prod-eks-nodes"
instance_type    = "t2.micro"  
desired_capacity = 2
min_capacity     = 1
max_capacity     = 3

# Optional Node Groups (Application/User tiers)
user_instance_type = "t2.micro"
app_instance_type  = "t2.micro"

# Tags
tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
