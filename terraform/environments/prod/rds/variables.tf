# =============================================================================
# PRODUCTION RDS - VARIABLES (ENTERPRISE GRADE)
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
  description = "Production VPC ID where RDS will be created"
  type        = string
}

variable "database_security_group_id" {
  description = "Production database security group ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of production subnet IDs for RDS"
  type        = list(string)
}

variable "db_name" {
  description = "Production database name"
  type        = string
  default     = "prodapp"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version (specific for production)"
  type        = string
  default     = "8.0.35"
}

variable "instance_class" {
  description = "Production RDS instance class"
  type        = string
  default     = "db.t3.small"
  
  validation {
    condition = can(regex("^db\\.(t3|r5|r6|m5|m6)", var.instance_class))
    error_message = "Instance class must be appropriate for production workloads."
  }
}

variable "parameter_group_family" {
  description = "DB parameter group family"
  type        = string
  default     = "mysql8.0"
}

variable "allocated_storage" {
  description = "Initial storage size in GB - Production"
  type        = number
  default     = 100
  
  validation {
    condition     = var.allocated_storage >= 100
    error_message = "Production databases must have at least 100GB storage."
  }
}

variable "max_allocated_storage" {
  description = "Maximum storage size for autoscaling"
  type        = number
  default     = 1000
}

variable "username" {
  description = "Database master username"
  type        = string
  default     = "prodadmin"
}

variable "password" {
  description = "Database master password (if not using random password)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "use_random_password" {
  description = "Use randomly generated password for enhanced security"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Backup retention period in days - Production compliance"
  type        = number
  default     = 30
  
  validation {
    condition     = var.backup_retention_period >= 30
    error_message = "Production backup retention must be at least 30 days for compliance."
  }
}

variable "backup_window" {
  description = "Production backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Production maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
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
    Backup                = "Required"
    Monitoring            = "Required"
    CostCenter            = "production"
    Support               = "24x7"
    Criticality           = "High"
  }
}
