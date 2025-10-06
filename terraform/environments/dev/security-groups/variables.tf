# =============================================================================
# SECURITY GROUPS ENVIRONMENT - VARIABLES  
# =============================================================================

variable "aws_region" {
  description = "AWS region for development resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "Development VPC ID (REQUIRED)"
  type        = string
}

variable "web_ingress_cidrs" {
  description = "CIDR blocks for web access (HTTP/HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "database_ingress_cidrs" {
  description = "CIDR blocks for database access"
  type        = list(string)
  default     = []
}

variable "database_source_sgs" {
  description = "Security group IDs allowed database access"
  type        = list(string)
  default     = []
}

variable "eks_control_plane_sgs" {
  description = "EKS control plane security group IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Development tags"
  type        = map(string)
  default     = {}
}
