aws_region  = "us-west-2"
environment = "prod"
vpc_id      = "vpc-094620e7f146a180b"  # Your prod VPC ID (create prod VPC first)

tags = {
  Environment = "prod"
  Project     = "aws-zero-touch"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
  CostCenter  = "Production"
}
