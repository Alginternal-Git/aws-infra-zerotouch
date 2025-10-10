# -----------------------------------------------------------------------------
# 4. Outputs
# -----------------------------------------------------------------------------
output "keypair_name" {
  description = "AWS key pair name"
  value       = aws_key_pair.kp.key_name
}

output "private_key_path" {
  description = "Path to the generated PEM file"
  value       = local_file.private_key_file.filename
}
