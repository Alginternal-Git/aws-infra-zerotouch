# ----------------------------------------------------------------------------- 
# Outputs
# -----------------------------------------------------------------------------
output "keypair_name" {
  value = "${var.environment}-key-pair"
}

output "private_key_path" {
  value = local_file.private_key_file.filename
}