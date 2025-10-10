# =============================================================================
# OUTPUTS - PROD ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================
# These outputs display the generated AWS key pair name and the local path
# of the saved PEM file for production.
# =============================================================================

output "keypair_name" {
  description = "AWS Key Pair Name created for prod environment"
  value       = module.key_pair.key_name
}

output "keypair_private_key_path" {
  description = "Local path of the generated PEM file for prod"
  value       = module.key_pair.private_key_path
}
