# =============================================================================
# VARIABLES - DEV ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================
# These variables are used by the dev environment to deploy the AWS key pair.
# They are dynamically passed from the pipeline or Terraform CLI.
# =============================================================================

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "key_name" {
  default = "dev-keypair"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "aws-zero-touch"
    Owner       = "DevOps-Team"
    CreatedBy   = "Terraform"
    ManagedBy   = "Zero-Touch-Infrastructure"
    Environment = "dev"
  }
}