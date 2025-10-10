# =============================================================================
# OUTPUTS - DEV ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================

output "keypair_name" {
  description = "AWS Key Pair Name created for dev environment"
  value       = module.key_pair.keypair_name
}

output "private_key_path" {
  description = "Local path of the generated PEM file"
  value       = module.key_pair.private_key_path
}
