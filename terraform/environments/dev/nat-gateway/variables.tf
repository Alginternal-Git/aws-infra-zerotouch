# =============================================================================
# DEVELOPMENT NAT GATEWAY - VARIABLES (COMPLETE)
# =============================================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID where NAT Gateway will be created"
  type        = string
}

# ADD THIS MISSING VARIABLE
variable "single_nat_gateway" {
  description = "Use single NAT Gateway for cost savings in development"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
  }
}
