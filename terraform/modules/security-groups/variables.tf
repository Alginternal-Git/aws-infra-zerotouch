# =============================================================================
# SECURITY GROUPS MODULE - INPUT VARIABLES
# =============================================================================
# These variables allow customization of security groups for different
# environments (dev, staging, prod) and use cases
# =============================================================================

# -----------------------------------------------------------------------------
# REQUIRED VARIABLES
# -----------------------------------------------------------------------------

variable "environment" {
  description = "Environment name (dev, staging, prod, etc.)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "Environment must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "VPC ID must be a valid AWS VPC ID starting with 'vpc-'."
  }
}

# -----------------------------------------------------------------------------
# WEB SECURITY GROUP CONFIGURATION
# -----------------------------------------------------------------------------

variable "web_ingress_cidrs" {
  description = "CIDR blocks allowed to access web servers (HTTP/HTTPS ports 80,443)"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Internet access by default
  
  # Examples:
  # ["0.0.0.0/0"]                    # Allow from internet (public web servers)
  # ["10.0.0.0/16"]                  # Allow from VPC only (internal web servers)
  # ["203.0.113.0/24", "198.51.100.0/24"]  # Allow from specific networks
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks allowed SSH access (port 22) - SECURITY CRITICAL!"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Default allows all - CHANGE THIS!
  
  # SECURITY WARNING: Never use 0.0.0.0/0 in production!
  # Examples:
  # ["203.0.113.100/32"]             # Your office IP only
  # ["198.51.100.0/24"]              # Your company network
  # ["10.0.0.0/16"]                  # VPC CIDR only (bastion host access)
}

# -----------------------------------------------------------------------------  
# DATABASE SECURITY GROUP CONFIGURATION
# -----------------------------------------------------------------------------

variable "database_ingress_cidrs" {
  description = "CIDR blocks allowed to access databases (ports 3306,5432)"
  type        = list(string)
  default     = []  # Empty by default - use security groups instead
  
  # SECURITY NOTE: Prefer security groups over CIDR blocks for databases
  # Examples:
  # ["10.0.0.0/16"]                  # VPC CIDR (less secure than SG reference)
  # []                               # Recommended - use database_source_sgs instead
}

variable "database_source_sgs" {
  description = "Security group IDs allowed to access databases (PREFERRED method)"
  type        = list(string)
  default     = []  # Will be populated with web SG ID after creation
  
  # Examples:
  # [aws_security_group.web.id]     # Allow from web security group
  # ["sg-12345678", "sg-87654321"]  # Specific security group IDs
  # []                               # Will be updated after web SG creation
}

# -----------------------------------------------------------------------------
# EKS SECURITY GROUP CONFIGURATION  
# -----------------------------------------------------------------------------

variable "eks_control_plane_sgs" {
  description = "EKS control plane security group IDs (for node communication)"
  type        = list(string)
  default     = []  # Will be populated after EKS cluster creation
  
  # Note: This is automatically created by EKS service
  # Examples:
  # ["sg-eks123456"]                 # EKS control plane security group ID
  # []                               # Leave empty until EKS cluster exists
}


# Add these new variables for bastion and app security groups

# Bastion Security Group Variables
variable "create_bastion_sg" {
  description = "Create bastion host security group"
  type        = bool
  default     = true
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH to bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # RESTRICT THIS IN PRODUCTION!
}

# Application Servers Security Group Variables
variable "create_app_sg" {
  description = "Create application servers security group"
  type        = bool
  default     = false
}

variable "app_ports" {
  description = "Custom application ports to allow from bastion"
  type        = list(number)
  default     = [8080, 3000, 8000]
}

# -----------------------------------------------------------------------------
# GENERAL CONFIGURATION
# -----------------------------------------------------------------------------

variable "tags" {
  description = "Tags to apply to all security groups (cost tracking, ownership)"
  type        = map(string)
  default     = {}
  
  # Examples:
  # {
  #   Environment = "prod"
  #   Project     = "web-app"
  #   Owner       = "devops-team"  
  #   CostCenter  = "engineering"
  #   CreatedBy   = "terraform"
  # }
}
