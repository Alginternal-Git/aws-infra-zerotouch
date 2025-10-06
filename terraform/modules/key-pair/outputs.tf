output "key_name" {
  description = "SSH key pair name"
  value       = aws_key_pair.kp.key_name
}

output "private_key_path" {
  description = "Local private key file path"
  value       = local_file.private_key_file.filename
}

output "private_key_ssm_name" {
  description = "SSM Parameter name of stored private key (if any)"
  value       = var.store_private_key_ssm ? aws_ssm_parameter.private_key_ssm[0].name : ""
}
