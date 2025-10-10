# =============================================================================
# DEVELOPMENT EC2 OUTPUTS
# =============================================================================
# Provides summary of EC2 instances created in the dev environment
# including Bastion Host and Application Server details.
# =============================================================================

# Bastion Instance Details
output "dev_bastion_instance_id" {
  description = "The ID of the development Bastion EC2 instance"
  value       = try(module.ec2.bastion_instance_id, null)
}

output "dev_bastion_public_ip" {
  description = "The public Elastic IP of the Bastion host (for SSH access)"
  value       = try(module.ec2.bastion_public_ip, null)
}

# Application Servers Details
output "dev_app_server_ids" {
  description = "The IDs of the development application servers"
  value       = try(module.ec2.app_server_ids, [])
}

output "dev_app_private_ips" {
  description = "The private IP addresses of development application servers"
  value       = try(module.ec2.app_private_ips, [])
}

# Environment Summary
output "dev_ec2_summary" {
  description = "Summary of EC2 instances and networking for development environment"
  value = {
    environment       = var.environment
    region            = var.aws_region
    vpc_id            = data.aws_vpc.selected.id
    bastion_instance  = try(module.ec2.bastion_instance_id, "not created")
    bastion_public_ip = try(module.ec2.bastion_public_ip, "not assigned")
    app_count         = length(try(module.ec2.app_server_ids, []))
    app_private_ips   = try(module.ec2.app_private_ips, [])
    key_name           = data.aws_key_pair.existing.key_name
    status            = "Development Environment Deployed Successfully"
  }
}
