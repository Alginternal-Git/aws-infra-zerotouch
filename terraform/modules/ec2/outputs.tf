output "bastion_public_ip" {
  value = try(aws_eip.bastion[0].public_ip, null)
}

output "bastion_instance_id" {
  value = try(aws_instance.bastion[0].id, null)
}

output "app_instance_ids" {
  value = aws_instance.app_servers[*].id
}

output "app_private_ips" {
  value = aws_instance.app_servers[*].private_ip
}

output "ec2_summary" {
  value = {
    environment        = var.environment
    bastion_public_ip  = try(aws_eip.bastion[0].public_ip, null)
    app_server_count   = var.app_server_count
    app_private_ips    = aws_instance.app_servers[*].private_ip
  }
}
