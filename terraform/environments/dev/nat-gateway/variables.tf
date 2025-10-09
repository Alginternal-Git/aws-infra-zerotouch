# =============================================================================
# DEVELOPMENT NAT GATEWAY - VARIABLES (FINAL)
# =============================================================================

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT Gateway for cost savings"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
