# =============================================================================
# VARIABLES - PRODUCTION SECURITY GROUPS
# =============================================================================
# These variables define all configurable inputs for the production SG setup.
# They mirror the dev environment variables but enforce stricter defaults.
# =============================================================================

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev, staging)"
  type        = string
}

# -----------------------------------------------------------------------------
# NETWORK CONFIGURATION
# -----------------------------------------------------------------------------

variable "vpc_id" {
  description = "Production VPC ID (auto-fetched via data block if tagged)"
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# ACCESS CONTROL CONFIGURATIONS
# -----------------------------------------------------------------------------

variable "web_ingress_cidrs" {
  description = "CIDR blocks allowed for web access (HTTP/HTTPS)"
  type        = list(string)
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks allowed for SSH access to bastion or servers"
  type        = list(string)
}

variable "database_ingress_cidrs" {
  description = "CIDR blocks allowed to access the database (PostgreSQL/MySQL)"
  type        = list(string)
  default     = []
}

variable "database_source_sgs" {
  description = "Security group IDs allowed to connect to the database"
  type        = list(string)
  default     = []
}

variable "eks_control_plane_sgs" {
  description = "EKS control plane security groups (if applicable)"
  type        = list(string)
  default     = []
}

# -----------------------------------------------------------------------------
# OPTIONAL SECURITY GROUP CREATION
# -----------------------------------------------------------------------------

variable "create_bastion_sg" {
  description = "Whether to create a bastion host security group"
  type        = bool
  default     = true
}

variable "create_app_sg" {
  description = "Whether to create an application server security group"
  type        = bool
  default     = true
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH into bastion host"
  type        = list(string)
  default     = []
}

variable "app_ports" {
  description = "Application ports allowed between app and other layers"
  type        = list(number)
  default     = [8080, 8443]
}

# -----------------------------------------------------------------------------
# TAG CONFIGURATION
# -----------------------------------------------------------------------------

variable "tags" {
  description = "Key-value tags applied to all security groups"
  type        = map(string)
  default     = {}
}
