# Production Configuration
aws_region            = "us-west-2"
environment           = "prod"
vpc_id                = "vpc-094620e7f146a180b"      # Your production VPC
bastion_sg_id         = "sg-034dbedb6e3e63e56"      #  prod-bastion-sg
app_sg_id             = "sg-02d9b3b824c276c3a"      #  prod-web-sg
key_name              = "prod-prod-keypair"         #  Your new production key
bastion_instance_type = "t3.small"
app_instance_type     = "t3.medium"
app_server_count      = 0  # Start with bastion only

# Production Tags
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
