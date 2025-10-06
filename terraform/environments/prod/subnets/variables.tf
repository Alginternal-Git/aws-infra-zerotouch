variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "create_public_subnets" {
  description = "Create public subnets"
  type        = bool
  default     = true
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID"
  type        = string
  default     = null
}

variable "public_subnets" {
  description = "Public subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "private_subnets" {
  description = "Private subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "zero-touch"
    Region      = "us-west-2"
  }
}
