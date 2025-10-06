# =============================================================================
# DEVELOPMENT RDS - OUTPUTS
# =============================================================================

output "db_instance_id" {
  description = "Development database instance identifier"
  value       = module.rds.db_instance_id
}

output "db_endpoint" {
  description = "Development database endpoint"
  value       = module.rds.db_instance_endpoint
  sensitive   = true
}

output "db_address" {
  description = "Development database hostname"
  value       = module.rds.db_instance_address
  sensitive   = true
}

output "db_port" {
  description = "Development database port"
  value       = module.rds.db_instance_port
}

output "db_name" {
  description = "Development database name"
  value       = module.rds.db_instance_name
}

output "connection_string" {
  description = "Development database connection string"
  value       = module.rds.connection_string
  sensitive   = true
}

output "dev_database_summary" {
  description = "Summary of development database"
  value = {
    environment = "dev"
    region     = "us-east-1"
    vpc_id     = var.vpc_id
    db_id      = module.rds.db_instance_id
    db_engine  = var.engine
    instance_class = var.instance_class
    storage_gb = var.allocated_storage
  }
}
