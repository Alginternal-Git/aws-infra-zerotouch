# =============================================================================
# PRODUCTION RDS - OUTPUTS (ENTERPRISE GRADE)
# =============================================================================

output "db_instance_id" {
  description = "Production database instance identifier"
  value       = module.rds.db_instance_id
}

output "db_instance_arn" {
  description = "Production database ARN"
  value       = module.rds.db_instance_arn
}

output "db_endpoint" {
  description = "Production database endpoint"
  value       = module.rds.db_instance_endpoint
  sensitive   = true
}

output "db_address" {
  description = "Production database hostname"
  value       = module.rds.db_instance_address
  sensitive   = true
}

output "db_port" {
  description = "Production database port"
  value       = module.rds.db_instance_port
}

output "db_name" {
  description = "Production database name"
  value       = module.rds.db_instance_name
}

output "db_username" {
  description = "Production database username"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "connection_string" {
  description = "Production database connection string"
  value       = module.rds.connection_string
  sensitive   = true
}

# KMS and Security Outputs
output "kms_key_id" {
  description = "KMS key ID for RDS encryption"
  value       = aws_kms_key.rds_encryption.key_id
}

output "kms_key_arn" {
  description = "KMS key ARN for RDS encryption"
  value       = aws_kms_key.rds_encryption.arn
}

output "kms_alias_name" {
  description = "KMS key alias name"
  value       = aws_kms_alias.rds_encryption.name
}

# Production Summary
output "prod_database_summary" {
  description = "Comprehensive summary of production database"
  value = {
    # Basic Info
    environment     = "prod"
    region         = "us-west-2"
    vpc_id         = var.vpc_id
    
    # Database Info
    db_id          = module.rds.db_instance_id
    db_engine      = var.engine
    engine_version = var.engine_version
    instance_class = var.instance_class
    
    # Storage Info
    storage_gb     = var.allocated_storage
    max_storage_gb = var.max_allocated_storage
    storage_type   = "gp3"
    encrypted      = true
    
    # Availability
    multi_az       = true
    backup_days    = var.backup_retention_period
    
    # Security
    kms_encrypted = true
    publicly_accessible = false
    random_password = var.use_random_password
  }
}

# Connection Information (for applications)
output "application_connection_info" {
  description = "Connection information for applications (sensitive)"
  value = {
    host     = module.rds.db_instance_address
    port     = module.rds.db_instance_port
    database = module.rds.db_instance_name
    username = module.rds.db_instance_username
    # Note: Password is not included in outputs for security
    ssl_mode = "require"
  }
  sensitive = true
}
