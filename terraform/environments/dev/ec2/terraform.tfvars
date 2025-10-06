aws_region            = "us-east-1"
environment           = "dev"
vpc_id                = "vpc-0f13f9687b72a6e03"
bastion_sg_id         = "sg-06ea978d8ef2586cd"
app_sg_id             = "sg-028ca0fcfa1b0d612"
key_name              = "dev-dev-keypair"
bastion_instance_type = "t3.micro"
app_instance_type     = "t3.small"
app_server_count      = 0

common_tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "dev-team"
}

resource_tags = {
  CostCenter = "development"
  Backup     = "daily"
}
