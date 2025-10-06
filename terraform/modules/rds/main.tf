# =============================================================================
# RDS MODULE - MAIN CONFIGURATION
# =============================================================================

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.db_name}-subnet-group"
  })
}

# DB Parameter Group
resource "aws_db_parameter_group" "main" {
  family = var.parameter_group_family
  name   = "${var.environment}-${var.db_name}-parameter-group"

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.db_name}-parameter-group"
  })
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier = "${var.environment}-${var.db_name}"

  # Database Configuration
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  
  # Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type         = var.storage_type
  storage_encrypted    = var.storage_encrypted

  # Database Settings
  db_name  = var.db_name
  username = var.username
  password = var.password

  # Network & Security
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.main.name
  parameter_group_name   = aws_db_parameter_group.main.name
  publicly_accessible    = var.publicly_accessible

  # Backup Configuration
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  # High Availability
  multi_az = var.multi_az

  # Final Snapshot
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.environment}-${var.db_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.db_name}"
  })
}
