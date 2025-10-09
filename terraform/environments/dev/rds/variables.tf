# =============================================================================
# DEVELOPMENT RDS VARIABLES
# =============================================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "devapp"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "parameter_group_family" {
  description = "DB parameter group family"
  type        = string
  default     = "mysql8.0"
}

variable "allocated_storage" {
  description = "Initial storage (GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Max storage (GB)"
  type        = number
  default     = 50
}

variable "storage_encrypted" {
  description = "Enable encryption"
  type        = bool
  default     = true
}

variable "username" {
  description = "DB master username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "DB master password"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Backup retention (days)"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
  }
}
