variable "aws_region" {
  description = "AWS region where keypair will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "key_name" {
  description = "Base name for the key pair"
  type        = string
  default     = "keypair"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
