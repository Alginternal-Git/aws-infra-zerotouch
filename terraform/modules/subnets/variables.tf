variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "create_public_subnets" {
  description = "Create public subnets with internet access"
  type        = bool
  default     = true
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID"
  type        = string
  default     = null
}

variable "public_subnets" {
  description = "Public subnets configuration"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "private_subnets" {
  description = "Private subnets configuration"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
