# =============================================================================
# MODULE: Key Pair
# Description: Creates an EC2 Key Pair (public in AWS, private PEM locally)
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# ----------------------------------------------------------------------------- 
# Generate a private key locally
# -----------------------------------------------------------------------------
resource "tls_private_key" "kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ----------------------------------------------------------------------------- 
# Create AWS key pair with environment-based name
# -----------------------------------------------------------------------------
resource "aws_key_pair" "kp" {
  key_name   = "${var.environment}-key-pair"
  public_key = tls_private_key.kp.public_key_openssh
}

# ----------------------------------------------------------------------------- 
# Save private key to a PEM file (artifact)
# -----------------------------------------------------------------------------
resource "local_file" "private_key_file" {
  content         = tls_private_key.kp.private_key_pem
  filename        = "${path.module}/${var.environment}-key-pair.pem"
  file_permission = "0600"
}


