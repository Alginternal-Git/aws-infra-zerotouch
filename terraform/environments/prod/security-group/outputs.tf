# =============================================================================
# PRODUCTION SECURITY GROUPS - OUTPUTS (CORRECTED)
# =============================================================================

# Web Security Group Outputs
output "web_security_group_id" {
  description = "ID of the production web security group"
  value       = module.security_groups.web_security_group_id
}

output "web_security_group_arn" {
  description = "ARN of the production web security group"
  value       = module.security_groups.web_security_group_arn
}

# Database Security Group Outputs
output "database_security_group_id" {
  description = "ID of the production database security group"
  value       = module.security_groups.database_security_group_id
}

output "database_security_group_arn" {
  description = "ARN of the production database security group"
  value       = module.security_groups.database_security_group_arn
}

# EKS Security Group Outputs - CORRECTED NAME
output "eks_nodes_security_group_id" {
  description = "ID of the production EKS nodes security group"
  value       = module.security_groups.eks_nodes_security_group_id
}

output "eks_nodes_security_group_arn" {
  description = "ARN of the production EKS nodes security group"
  value       = module.security_groups.eks_nodes_security_group_arn
}

# Load Balancer Security Group Outputs - CORRECTED NAME
output "loadbalancer_security_group_id" {
  description = "ID of the production load balancer security group"
  value       = module.security_groups.loadbalancer_security_group_id
}

output "loadbalancer_security_group_arn" {
  description = "ARN of the production load balancer security group"
  value       = module.security_groups.loadbalancer_security_group_arn
}

# Convenience Output - All Security Group IDs
output "all_security_group_ids" {
  description = "Map of all production security group names to IDs"
  value       = module.security_groups.all_security_group_ids
}

# Production Summary
output "prod_security_summary" {
  description = "Summary of production security groups created"
  value = {
    environment = "prod"
    region     = var.aws_region
    vpc_id     = var.vpc_id
    web_sg     = module.security_groups.web_security_group_id
    db_sg      = module.security_groups.database_security_group_id
    eks_sg     = module.security_groups.eks_nodes_security_group_id
    lb_sg      = module.security_groups.loadbalancer_security_group_id
  }
}
