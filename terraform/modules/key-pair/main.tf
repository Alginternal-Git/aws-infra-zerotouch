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

 # ------------------------------------------------------------
# Generate a new private key locally
# ------------------------------------------------------------
resource "tls_private_key" "kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ------------------------------------------------------------
# Save the private key as a .pem file inside the module folder
# ------------------------------------------------------------
resource "local_file" "private_key_file" {
  content         = tls_private_key.kp.private_key_pem
  filename        = "${path.module}/${var.environment}-${var.key_name}.pem"
  file_permission = "0600"
}

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