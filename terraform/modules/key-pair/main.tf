# =============================================================================
# MODULE: Key Pair
# Description: Generates SSH key pair for EC2 access, uploads to AWS,
#              and stores private key locally as PEM file.
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
# 1. Generate SSH key pair locally
# -----------------------------------------------------------------------------
resource "tls_private_key" "kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# -----------------------------------------------------------------------------
# 2. Create AWS key pair (upload public key)
# -----------------------------------------------------------------------------
resource "aws_key_pair" "kp" {
  key_name   = "${var.environment}-${var.key_name}"
  public_key = tls_private_key.kp.public_key_openssh
}

# -----------------------------------------------------------------------------
# 3. Save private key locally in module folder
# -----------------------------------------------------------------------------
resource "local_file" "private_key_file" {
  content         = tls_private_key.kp.private_key_pem
  filename        = "${path.module}/${var.environment}-${var.key_name}.pem"
  file_permission = "0600"
}
