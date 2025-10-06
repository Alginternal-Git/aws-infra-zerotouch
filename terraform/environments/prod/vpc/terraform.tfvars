aws_region  = "us-west-2"
environment = "prod"
vpc_cidr    = "10.1.0.0/16"

tags = {
  Environment = "prod"
  Project     = "aws-zero-touch"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
  ManagedBy   = "Zero-Touch-Infrastructure"
  CostCenter  = "Production"
}
