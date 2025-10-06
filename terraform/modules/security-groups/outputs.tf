# =============================================================================
# SECURITY GROUPS MODULE - OUTPUTS  
# =============================================================================
# These outputs provide security group IDs for use by other modules
# (EC2, RDS, EKS, ALB, etc.)
# =============================================================================

# -----------------------------------------------------------------------------
# WEB SECURITY GROUP OUTPUTS
# -----------------------------------------------------------------------------

output "web_security_group_id" {
  description = "ID of the web security group (for EC2, ECS, application servers)"
  value       = aws_security_group.web.id
  # Example value: "sg-0123456789abcdef0"
}

output "web_security_group_arn" {
  description = "ARN of the web security group" 
  value       = aws_security_group.web.arn
  # Example value: "arn:aws:ec2:us-west-2:123456789012:security-group/sg-0123456789abcdef0"
}

# -----------------------------------------------------------------------------
# DATABASE SECURITY GROUP OUTPUTS  
# -----------------------------------------------------------------------------

output "database_security_group_id" {
  description = "ID of the database security group (for RDS, Aurora, DocumentDB)"
  value       = aws_security_group.database.id
  # Used by: RDS modules, database instances
}

output "database_security_group_arn" {
  description = "ARN of the database security group"
  value       = aws_security_group.database.arn
}

# -----------------------------------------------------------------------------
# EKS SECURITY GROUP OUTPUTS
# -----------------------------------------------------------------------------

output "eks_nodes_security_group_id" {
  description = "ID of the EKS nodes security group (for EKS worker nodes)"
  value       = aws_security_group.eks_nodes.id  
  # Used by: EKS node groups, EKS modules
}

output "eks_nodes_security_group_arn" {
  description = "ARN of the EKS nodes security group"
  value       = aws_security_group.eks_nodes.arn
}

# -----------------------------------------------------------------------------
# LOAD BALANCER SECURITY GROUP OUTPUTS
# -----------------------------------------------------------------------------

output "loadbalancer_security_group_id" {
  description = "ID of the load balancer security group (for ALB, NLB)"
  value       = aws_security_group.loadbalancer.id
  # Used by: ALB modules, load balancer resources
}

output "loadbalancer_security_group_arn" {
  description = "ARN of the load balancer security group"
  value       = aws_security_group.loadbalancer.arn
}

# -----------------------------------------------------------------------------
# CONVENIENCE OUTPUTS - ALL SECURITY GROUPS
# -----------------------------------------------------------------------------

output "all_security_group_ids" {
  description = "Map of all security group names to their IDs (convenience)"
  value = {
    web          = aws_security_group.web.id
    database     = aws_security_group.database.id  
    eks_nodes    = aws_security_group.eks_nodes.id
    loadbalancer = aws_security_group.loadbalancer.id
  }
  # Example usage: module.sg.all_security_group_ids["web"]
}

output "all_security_group_arns" {
  description = "Map of all security group names to their ARNs"
  value = {
    web          = aws_security_group.web.arn
    database     = aws_security_group.database.arn
    eks_nodes    = aws_security_group.eks_nodes.arn
    loadbalancer = aws_security_group.loadbalancer.arn
  }
}

# Add these new outputs for bastion and app security groups

output "bastion_security_group_id" {
  description = "ID of the bastion security group"
  value       = var.create_bastion_sg ? aws_security_group.bastion[0].id : null
}

output "app_security_group_id" {
  description = "ID of the application servers security group"  
  value       = var.create_app_sg ? aws_security_group.app_servers[0].id : null
}
