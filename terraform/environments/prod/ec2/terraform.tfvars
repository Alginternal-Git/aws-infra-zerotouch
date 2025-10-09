# =============================================================================
# PRODUCTION TERRAFORM VALUES - EC2 (DYNAMIC)
# =============================================================================

aws_region  = "us-west-2"
environment = "prod"

key_name              = "prod-prod-keypair"
bastion_instance_type = "t3.micro"
app_instance_type     = "t2.micro"

app_server_count      = 3 # only bastion for now

enable_web_sg = true
enable_db_sg  = true
enable_lb_sg  = true

common_tags = {
  Environment = "prod"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "prod-team"
}

resource_tags = {
  CostCenter       = "production"
  Backup           = "daily"
  Monitoring       = "enabled"
  HighAvailability = "true"
  Compliance       = "required"
  DataClass        = "confidential"
}
