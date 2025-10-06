# =============================================================================
# NAT GATEWAY MODULE - VARIABLES
# =============================================================================

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where NAT Gateways will be created"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID (dependency for NAT Gateways)"
  type        = string
}

variable "create_nat_gateways" {
  description = "Whether to create NAT Gateways"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Create a single NAT Gateway for all private subnets (cost-effective for dev)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy = "terraform"
  }
}
