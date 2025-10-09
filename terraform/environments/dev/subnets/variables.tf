variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
}
variable "create_public_subnets" {
  description = "Create public subnets"
  type        = bool
  default     = true
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
  default     = {}
}
