# =============================================================================
# RDS MODULE VARIABLES
# =============================================================================

variable "environment" { type = string }
variable "db_name" { type = string }
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "instance_class" { type = string }
variable "parameter_group_family" { type = string }
variable "allocated_storage" { type = number }
variable "max_allocated_storage" { type = number }
variable "storage_encrypted" { type = bool }
variable "username" { type = string }
variable "password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }

variable "backup_retention_period" { type = number }
variable "backup_window" { type = string }
variable "maintenance_window" { type = string }

variable "multi_az" { type = bool }
variable "skip_final_snapshot" { type = bool }
variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}

variable "deletion_protection" { type = bool }

variable "tags" { type = map(string) }

variable "storage_type" {
  description = "Type of RDS storage (e.g., gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "kms_key_id" {
  description = "ARN of KMS key for encryption"
  type        = string
  default     = null
}
