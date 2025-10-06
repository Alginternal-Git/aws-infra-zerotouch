# =============================================================================
# PRODUCTION SECURITY GROUPS - VARIABLES
# =============================================================================
# Production-specific variable definitions with secure defaults
# =============================================================================

variable "aws_region" {
  description = "AWS region for production resources"
  type        = string
  default     = "us-west-2"  # Production region
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
  
  validation {
    condition     = var.environment == "prod"
    error_message = "This configuration is for production only."
  }
}

variable "vpc_id" {
  description = "Production VPC ID (REQUIRED - must be provided)"
  type        = string
  # No default - must be explicitly provided for production
  
  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "VPC ID must be valid AWS VPC ID."
  }
}

# Web access variables
variable "web_ingress_cidrs" {
  description = "CIDR blocks for web access (HTTP/HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Allow web traffic from internet
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks for SSH access - PRODUCTION RESTRICTED"
  type        = list(string)
  default     = []  # No default - MUST be explicitly set for production
  
  validation {
    condition     = length(var.ssh_ingress_cidrs) > 0 && !contains(var.ssh_ingress_cidrs, "0.0.0.0/0")
    error_message = "Production SSH access must be restricted - cannot be empty or allow 0.0.0.0/0."
  }
}

# Database access variables  
variable "database_ingress_cidrs" {
  description = "CIDR blocks for database access"
  type        = list(string)
  default     = []  # Use security group references instead
}

variable "database_source_sgs" {
  description = "Security group IDs allowed database access"
  type        = list(string)
  default     = []  # Will be populated after web SG creation
}

# EKS variables
variable "eks_control_plane_sgs" {
  description = "EKS control plane security group IDs"
  type        = list(string) 
  default     = []
}

# Tags
variable "tags" {
  description = "Production tags"
  type        = map(string)
  default     = {}
}
