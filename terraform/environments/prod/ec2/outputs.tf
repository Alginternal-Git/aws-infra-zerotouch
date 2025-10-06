output "bastion_public_ip" {
  description = "Production bastion public IP"
  value       = module.ec2.bastion_public_ip
}

output "ssh_bastion" {
  description = "SSH command for production bastion"
  value       = module.ec2.bastion_public_ip != null ? "ssh -i ../../../key-pair/keys/prod/prod-prod-keypair.pem ec2-user@${module.ec2.bastion_public_ip}" : null
}

output "app_server_ips" {
  description = "Production app server private IPs"
  value       = module.ec2.app_server_private_ips
}

output "app_server_details" {
  description = "Production app server details"
  value       = module.ec2.app_server_details
}

output "bastion_instance_id" {
  description = "Production bastion instance ID"
  value       = module.ec2.bastion_instance_id
}

output "region" {
  description = "Production deployment region"
  value       = var.aws_region
}

output "key_pair_used" {
  description = "SSH key pair used for production"
  value       = var.key_name
}
