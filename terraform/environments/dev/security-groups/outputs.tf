# =============================================================================
# OUTPUTS - SECURITY GROUPS
# =============================================================================
# This file outputs all created security group IDs and ARNs for integration
# with other modules such as EC2, RDS, and EKS.
# =============================================================================

# -----------------------------------------------------------------------------
# Core Security Group Outputs
# -----------------------------------------------------------------------------
output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = module.security_groups.web_security_group_id
}

output "database_security_group_id" {
  description = "ID of the database security group"
  value       = module.security_groups.database_security_group_id
}

output "loadbalancer_security_group_id" {
  description = "ID of the load balancer security group"
  value       = module.security_groups.loadbalancer_security_group_id
}

output "eks_nodes_security_group_id" {
  description = "ID of the EKS worker nodes security group"
  value       = module.security_groups.eks_nodes_security_group_id
}

# -----------------------------------------------------------------------------
# Optional: Bastion and App Server SGs (only if created)
# -----------------------------------------------------------------------------
output "bastion_security_group_id" {
  description = "ID of the bastion security group (if created)"
  value       = try(module.security_groups.bastion_security_group_id, null)
}

output "app_servers_security_group_id" {
  description = "ID of the application servers security group (if created)"
  value       = try(module.security_groups.app_servers_security_group_id, null)
}

# -----------------------------------------------------------------------------
# Combined Outputs for Automation
# -----------------------------------------------------------------------------
output "all_security_group_ids" {
  description = "Map of all security group IDs created by this module"
  value       = module.security_groups.all_security_group_ids
}

output "all_security_group_arns" {
  description = "Map of all security group ARNs created by this module"
  value       = module.security_groups.all_security_group_arns
}

# -----------------------------------------------------------------------------
# Environment Summary (for downstream use)
# -----------------------------------------------------------------------------
output "security_summary" {
  description = "Summary of key SGs and environment context"
  value = {
    environment = var.environment
    region      = var.aws_region
    vpc_id      = data.aws_vpc.selected.id
    web_sg      = module.security_groups.web_security_group_id
    db_sg       = module.security_groups.database_security_group_id
    lb_sg       = module.security_groups.loadbalancer_security_group_id
    eks_sg      = module.security_groups.eks_nodes_security_group_id
    bastion_sg  = try(module.security_groups.bastion_security_group_id, null)
    app_sg      = try(module.security_groups.app_servers_security_group_id, null)
  }
}
