# =============================================================================
# VARIABLES - DEVELOPMENT SECURITY GROUPS
# =============================================================================
# These variables control how the security group module is deployed in dev.
# =============================================================================

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

# -----------------------------------------------------------------------------
# SECURITY GROUP CONFIGURATION
# -----------------------------------------------------------------------------

variable "web_ingress_cidrs" {
  description = "CIDR blocks allowed to access web servers (HTTP/HTTPS)"
  type        = list(string)
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks allowed SSH access (port 22)"
  type        = list(string)
}

variable "database_ingress_cidrs" {
  description = "CIDR blocks allowed to access databases (e.g. PostgreSQL, MySQL)"
  type        = list(string)
}

variable "database_source_sgs" {
  description = "Security group IDs allowed to access databases (preferred)"
  type        = list(string)
  default     = []
}

variable "eks_control_plane_sgs" {
  description = "EKS control plane security group IDs (optional)"
  type        = list(string)
  default     = []
}

# -----------------------------------------------------------------------------
# OPTIONAL SECURITY GROUP CREATION FLAGS
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
  description = "CIDR blocks allowed SSH access to bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_ports" {
  description = "List of application ports to allow from bastion host"
  type        = list(number)
  default     = [8080, 3000, 8000]
}

# -----------------------------------------------------------------------------
# TAGGING CONFIGURATION
# -----------------------------------------------------------------------------

variable "tags" {
  description = "Tags to apply to all security groups"
  type        = map(string)
}
