output "bastion_public_ip" {
  description = "Public IP of bastion host"
  value       = var.create_bastion ? aws_eip.bastion[0].public_ip : null
}

output "bastion_instance_id" {
  description = "Instance ID of bastion host"
  value       = var.create_bastion ? aws_instance.bastion[0].id : null
}

output "bastion_private_ip" {
  description = "Private IP of bastion host"
  value       = var.create_bastion ? aws_instance.bastion[0].private_ip : null
}

output "app_server_ids" {
  description = "Instance IDs of app servers"
  value       = aws_instance.app_servers[*].id
}

output "app_server_private_ips" {
  description = "Private IPs of app servers"
  value       = aws_instance.app_servers[*].private_ip
}

output "app_server_details" {
  description = "App servers details"
  value = {
    for i, instance in aws_instance.app_servers :
    "app-server-${i + 1}" => {
      id         = instance.id
      private_ip = instance.private_ip
      az         = instance.availability_zone
    }
  }
}
