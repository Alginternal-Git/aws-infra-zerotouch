variable "aws_region" {
  description = "AWS region for production"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "vpc_id" {
  description = "Production VPC ID"
  type        = string
}

variable "bastion_sg_id" {
  description = "Production bastion security group ID"
  type        = string
}

variable "app_sg_id" {
  description = "Production app security group ID"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for production"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for production bastion"
  type        = string
  default     = "t3.small"
}

variable "app_instance_type" {
  description = "Instance type for production app servers"
  type        = string
  default     = "t3.medium"
}

variable "app_server_count" {
  description = "Number of app servers in production"
  type        = number
  default     = 0
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
