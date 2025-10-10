# =============================================================================
# MODULE: Key Pair
# Description: Creates an AWS EC2 key pair and saves the private key locally
# Author: Prathyusha Y
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Random ID to avoid duplicate key names
resource "random_id" "suffix" {
  byte_length = 2
}

# Generate a new private key locally
resource "tls_private_key" "kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair from the generated public key
resource "aws_key_pair" "kp" {
  key_name   = "${var.environment}-${var.key_name}-${random_id.suffix.hex}"
  public_key = tls_private_key.kp.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-${var.key_name}"
      Environment = var.environment
      ManagedBy   = "Zero-Touch-Infrastructure"
      CreatedBy   = "Terraform"
    }
  )
}

# Save private key locally (optional)
resource "local_file" "private_key_file" {
  content  = tls_private_key.kp.private_key_pem
  filename = "${path.module}/${var.environment}-${var.key_name}.pem"

  # Restrict permissions to owner only
  file_permission = "0600"
}

# Output key info
output "key_name" {
  description = "AWS Key Pair Name"
  value       = aws_key_pair.kp.key_name
}

output "private_key_path" {
  description = "Local path of generated private key file"
  value       = local_file.private_key_file.filename
}
