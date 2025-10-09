# =============================================================================
# DEVELOPMENT RDS - OUTPUTS (UPDATED FOR DATA BLOCKS)
# =============================================================================

# -----------------------------------------------------------------------------
# CORE DATABASE DETAILS
# -----------------------------------------------------------------------------
output "db_instance_id" {
  description = "Development RDS instance identifier"
  value       = module.rds.db_instance_id
}

output "db_endpoint" {
  description = "Development RDS database endpoint"
  value       = module.rds.db_instance_endpoint
  sensitive   = true
}

output "db_address" {
  description = "Development RDS hostname (DNS endpoint)"
  value       = module.rds.db_instance_address
  sensitive   = true
}

output "db_port" {
  description = "Development RDS port number"
  value       = module.rds.db_instance_port
}

output "db_name" {
  description = "Development RDS database name"
  value       = module.rds.db_instance_name
}

# -----------------------------------------------------------------------------
# CONNECTION DETAILS
# -----------------------------------------------------------------------------
output "connection_string" {
  description = "Development database connection string (for app integration)"
  value       = module.rds.connection_string
  sensitive   = true
}

# -----------------------------------------------------------------------------
# DEVELOPMENT RDS SUMMARY
# -----------------------------------------------------------------------------
output "dev_database_summary" {
  description = "Summary of RDS resources in development environment"
  value = {
    environment      = var.environment
    region           = var.aws_region
    vpc_id           = data.aws_vpc.selected.id
    private_subnets  = data.aws_subnets.private.ids
    database_sg_id   = data.aws_security_group.database.id
    db_identifier    = module.rds.db_instance_id
    db_engine        = var.engine
    instance_class   = var.instance_class
    storage_gb       = var.allocated_storage
    endpoint         = module.rds.db_instance_endpoint
    port             = module.rds.db_instance_port
  }
  sensitive = true
}
