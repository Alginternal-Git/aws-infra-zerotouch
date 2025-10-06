output "key_name" {
  description = "SSH key pair name created"
  value       = module.key_pair.key_name  # ✅ Correct - using underscore
}

output "private_key_path" {
  description = "Local path of private key"
  value       = module.key_pair.private_key_path  # ✅ Correct - using underscore
}