output "key_name" {
  description = "Name of the created AWS Key Pair"
  value       = aws_key_pair.kp.key_name
}

output "keypair_private_key_path" {
  description = "Path of the locally saved private key"
  value       = local_file.private_key_file.filename
}


