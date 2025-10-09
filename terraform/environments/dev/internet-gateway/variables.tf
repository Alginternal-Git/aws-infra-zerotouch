variable "aws_region" {
  description = "AWS region for Internet Gateway"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

