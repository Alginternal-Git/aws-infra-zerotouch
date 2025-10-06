# =============================================================================
# PRODUCTION NAT GATEWAY - VARIABLES (ENTERPRISE GRADE)
# =============================================================================

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
  description = "Production VPC ID where NAT Gateway will be created"
  type        = string
}

variable "single_nat_gateway" {
  description = "Use single NAT Gateway (false for production high availability)"
  type        = bool
  default     = false
  
  validation {
    condition     = var.single_nat_gateway == false
    error_message = "Production environment must use multiple NAT Gateways for high availability."
  }
}

variable "tags" {
  description = "Production tags for compliance and cost tracking"
  type        = map(string)
  default = {
    Environment            = "prod"
    Project               = "zero-touch"
    ManagedBy             = "terraform"
    Compliance            = "SOX"
    DataClassification    = "Internal"
    Support               = "24x7"
    Criticality           = "High"
    CostCenter            = "production"
    BackupRequired        = "Yes"
    MonitoringRequired    = "Yes"
  }
}
