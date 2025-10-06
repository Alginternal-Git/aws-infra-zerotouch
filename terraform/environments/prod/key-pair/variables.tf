variable "aws_region" {
  description = "AWS region for production keys"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "key_name" {
  description = "Base name for production key pair"
  type        = string
  default     = "prod-keypair"
}

variable "common_tags" {
  description = "Common tags for all production resources"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
  }
}

variable "resource_tags" {
  description = "Additional resource-specific tags"
  type        = map(string)
  default     = {}
}
