aws_region  = "us-west-2"
environment = "prod"
key_name    = "prod-keypair"

common_tags = {
  Environment = "prod"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "prod-team"
}

resource_tags = {
  Classification = "sensitive"
  Compliance     = "required"
  Backup         = "daily"
  Monitoring     = "enabled"
  CostCenter     = "production"
}
