# =============================================================================
# AWS CONFIGURATION
# =============================================================================
aws_region = "us-east-1"

# =============================================================================
# S3 BUCKET CONFIGURATION
# =============================================================================
# IMPORTANT: Bucket names must be globally unique across ALL AWS accounts
bucket_name = "my-dev-app-bucket-67890-unique"

# =============================================================================
# VERSIONING AND LIFECYCLE
# =============================================================================
versioning_enabled = false  # Dev doesn't need versioning (cost saving)
lifecycle_enabled   = false  # Clean up dev data regularly

# Object expiration settings (shorter retention for dev)
expiration_days                     = 30  # Delete after 30 days
noncurrent_version_expiration_days  = 7   # Delete old versions after 7 days

# =============================================================================
# SECURITY SETTINGS
# =============================================================================
block_public_access  = true      # Always secure
encryption_algorithm = "AES256"  # Basic encryption for dev
kms_key_id          = null      # Default encryption

# =============================================================================
# TAGS
# =============================================================================
tags = {
  Environment = "dev"
  Project     = "zero-touch"
  Region      = "us-east-1"
  Service     = "storage"
  CostCenter  = "Development"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
