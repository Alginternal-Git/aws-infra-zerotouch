# 
# AWS CONFIGURATION
# 
aws_region = "us-west-2"

# 
# S3 BUCKET CONFIGURATION
# 
# IMPORTANT: Bucket names must be globally unique across ALL AWS accounts
bucket_name = "my-prod-app-bucket-12345-unique"

# 
# VERSIONING AND LIFECYCLE
# 
versioning_enabled = true   # Production needs versioning for recovery
lifecycle_enabled   = false   # Automatic cleanup

# Object expiration settings
expiration_days                     = 2555  # 7 years retention for prod
noncurrent_version_expiration_days  = 365   # Keep old versions for 1 year

# 
# SECURITY SETTINGS
# 
block_public_access  = true      # Always block public access in prod
encryption_algorithm = "AES256"  # Server-side encryption
kms_key_id          = null      # Use default encryption

# 
# TAGS
# 
tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  Service     = "storage"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
