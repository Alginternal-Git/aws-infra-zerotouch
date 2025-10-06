# =============================================================================
# DEVELOPMENT SECURITY GROUPS - OUTPUTS
# =============================================================================
# Output values for development security groups to be used by other modules
# =============================================================================

# Web Security Group Outputs
output "web_security_group_id" {
  description = "ID of the development web security group"
  value       = module.security_groups.web_security_group_id
  # Example: "sg-0123456789abcdef0"
}

output "web_security_group_arn" {
  description = "ARN of the development web security group"
  value       = module.security_groups.web_security_group_arn
  # Example: "arn:aws:ec2:us-east-1:123456789012:security-group/sg-0123456789abcdef0"
}

# Database Security Group Outputs
output "database_security_group_id" {
  description = "ID of the development database security group"
  value       = module.security_groups.database_security_group_id
  # Used by RDS modules in development
}

output "database_security_group_arn" {
  description = "ARN of the development database security group"
  value       = module.security_groups.database_security_group_arn
}

# EKS Security Group Outputs
output "eks_nodes_security_group_id" {
  description = "ID of the development EKS nodes security group"
  value       = module.security_groups.eks_nodes_security_group_id
  # Used by EKS modules in development
}

output "eks_nodes_security_group_arn" {
  description = "ARN of the development EKS nodes security group"
  value       = module.security_groups.eks_nodes_security_group_arn
}

# Load Balancer Security Group Outputs
output "loadbalancer_security_group_id" {
  description = "ID of the development load balancer security group"
  value       = module.security_groups.loadbalancer_security_group_id
  # Used by ALB/NLB modules in development
}

output "loadbalancer_security_group_arn" {
  description = "ARN of the development load balancer security group"
  value       = module.security_groups.loadbalancer_security_group_arn
}

# Convenience Output - All Security Group IDs
output "all_security_group_ids" {
  description = "Map of all development security group names to IDs"
  value       = module.security_groups.all_security_group_ids
  # Example usage: local.dev_sg_ids = module.dev_security_groups.all_security_group_ids
}

# Convenience Output - All Security Group ARNs
output "all_security_group_arns" {
  description = "Map of all development security group names to ARNs"
  value       = module.security_groups.all_security_group_arns
}

# Development-specific output for easy reference
output "dev_security_summary" {
  description = "Summary of development security groups created"
  value = {
    environment = "dev"
    region     = var.aws_region
    vpc_id     = var.vpc_id
    web_sg     = module.security_groups.web_security_group_id
    db_sg      = module.security_groups.database_security_group_id
    eks_sg     = module.security_groups.eks_nodes_security_group_id
    lb_sg      = module.security_groups.loadbalancer_security_group_id
  }
}
