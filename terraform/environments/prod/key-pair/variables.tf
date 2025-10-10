# =============================================================================
# VARIABLES - prod ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================
# These variables are used by the prod environment to deploy the AWS key pair.
# They are dynamically passed from the pipeline or Terraform CLI.
# =============================================================================

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "prod"
}

variable "key_name" {
  default = "prod-keypair"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "aws-zero-touch"
    Owner       = "DevOps-Team"
    CreatedBy   = "Terraform"
    ManagedBy   = "Zero-Touch-Infrastructure"
    Environment = "prod"
  }
}