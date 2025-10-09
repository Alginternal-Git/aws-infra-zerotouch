# =============================================================================
# RDS MODULE OUTPUTS
# =============================================================================

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.this.port
}

output "db_instance_name" {
  description = "The name of the database"
  value       = aws_db_instance.this.db_name
}

output "db_instance_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.this.username
}

output "db_subnet_group_name" {
  description = "The DB subnet group name used for RDS"
  value       = aws_db_subnet_group.this.name
}

# (Optional) Parameter group if you have one
# output "db_parameter_group_name" {
#   description = "The DB parameter group name"
#   value       = aws_db_parameter_group.this.name
# }

output "connection_string" {
  description = "Connection string for the database"
  value       = "mysql://${aws_db_instance.this.username}:${var.password}@${aws_db_instance.this.endpoint}/${aws_db_instance.this.db_name}"
  sensitive   = true
}
