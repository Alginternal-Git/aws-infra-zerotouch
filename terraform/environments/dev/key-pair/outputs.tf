# =============================================================================
# OUTPUTS - DEV ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================
# These outputs display the generated AWS key pair name and location of
# the saved private key file.
# =============================================================================

output "keypair_name" {
  description = "AWS Key Pair Name created for dev environment"
  value       = module.key_pair.key_name
}

output "keypair_private_key_path" {
  description = "Local path of the generated PEM file"
  value       = module.key_pair.private_key_path
}
