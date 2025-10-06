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
  description = "VPC ID"
  type        = string
}

variable "bastion_sg_id" {
  description = "Bastion security group ID"
  type        = string
}

variable "app_sg_id" {
  description = "App security group ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "app_instance_type" {
  description = "Instance type for app servers"
  type        = string
  default     = "t3.small"
}

variable "app_server_count" {
  description = "Number of app servers"
  type        = number
  default     = 2
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
  }
}

variable "resource_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}
