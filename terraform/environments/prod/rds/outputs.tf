output "prod_rds_summary" {
  description = "Summary of production RDS resources"
  value = {
    environment     = var.environment
    vpc_id          = data.aws_vpc.selected.id
    private_subnets = data.aws_subnets.private.ids
    db_sg_id        = data.aws_security_group.database.id
    kms_key_arn     = aws_kms_key.rds_encryption.arn
    multi_az        = true
    db_engine       = var.engine
    storage_type    = "gp3"
    encryption      = "enabled"
    compliance      = "SOX"
  }
  sensitive = false
}