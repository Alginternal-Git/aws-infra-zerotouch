output "bastion_public_ip" {
  description = "Bastion public IP"
  value       = module.ec2.bastion_public_ip
}

output "ssh_bastion" {
  description = "SSH command for bastion"
  value       = module.ec2.bastion_public_ip != null ? "ssh -i ../../../key-pair/keys/dev/dev-dev-keypair.pem ec2-user@${module.ec2.bastion_public_ip}" : null
}

output "app_server_ips" {
  description = "App server private IPs"
  value       = module.ec2.app_server_private_ips
}

output "app_server_details" {
  description = "App server details"
  value       = module.ec2.app_server_details
}

output "ssh_commands_via_bastion" {
  description = "SSH commands to app servers via bastion"
  value = [
    for ip in module.ec2.app_server_private_ips :
    "ssh -i ../../../key-pair/keys/dev/dev-dev-keypair.pem -o ProxyCommand='ssh -i ../../../key-pair/keys/dev/dev-dev-keypair.pem -W %h:%p ec2-user@${module.ec2.bastion_public_ip}' ec2-user@${ip}"
  ]
}
