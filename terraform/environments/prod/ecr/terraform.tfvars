# PRODUCTION ECR CONFIGURATION
# Adjust values as necessary for your production environment
aws_region = "us-west-2"

# Repository Configuration
repository_name      = "my-prod-app"        # Change this to your app name
image_tag_mutability = "IMMUTABLE"          # Prevent tag overwrite in prod
scan_on_push         = true                 # Security scanning enabled
encryption_type      = "AES256"             # Image encryption
max_image_count      = 100                  # Keep more images in prod

tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  Service     = "container-registry"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
