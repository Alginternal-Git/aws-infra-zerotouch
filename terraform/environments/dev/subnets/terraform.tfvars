aws_region            = "us-east-1"
environment           = "dev"
vpc_id               = "vpc-0f13f9687b72a6e03"
create_public_subnets = true
internet_gateway_id   = "igw-0ae5b0791bc53a40d"

public_subnets = {
  "subnet-1a" = {
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
  }
  "subnet-1b" = {
    cidr = "10.0.2.0/24"
    az   = "us-east-1b"
  }
}

private_subnets = {
  "subnet-1a" = {
    cidr = "10.0.10.0/24"
    az   = "us-east-1a"
  }
  "subnet-1b" = {
    cidr = "10.0.20.0/24"
    az   = "us-east-1b"
  }
}

tags = {
  Environment = "dev"
  Project     = "aws-zero-touch"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
