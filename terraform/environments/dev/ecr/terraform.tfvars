# =============================================================================
# DEVELOPMENT ECR CONFIGURATION
# =============================================================================
aws_region = "us-east-1"

# Repository Configuration
repository_name      = "my-dev-app"         # Change this to your app name
image_tag_mutability = "MUTABLE"            # Allow tag overwrite in dev
scan_on_push         = false                # Skip scanning in dev (faster)
encryption_type      = "AES256"             # Basic encryption
max_image_count      = 10                   # Keep fewer images in dev

tags = {
  Environment = "dev"
  Project     = "zero-touch"
  Region      = "us-east-1"
  Service     = "container-registry"
  CostCenter  = "Development"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
