aws_region            = "us-west-2"
environment           = "prod"
vpc_id               = "vpc-094620e7f146a180b"  # Your prod VPC ID
create_public_subnets = true
internet_gateway_id   = "igw-00bcab006ae80c4f4"  # Your prod IGW ID

public_subnets = {
  "subnet-2a" = {
    cidr = "10.1.1.0/24"
    az   = "us-west-2a"
  }
  "subnet-2b" = {
    cidr = "10.1.2.0/24"
    az   = "us-west-2b"
  }
  "subnet-2c" = {
    cidr = "10.1.3.0/24"
    az   = "us-west-2c"
  }
}

private_subnets = {
  "subnet-2a" = {
    cidr = "10.1.10.0/24"
    az   = "us-west-2a"
  }
  "subnet-2b" = {
    cidr = "10.1.20.0/24"
    az   = "us-west-2b"
  }
  "subnet-2c" = {
    cidr = "10.1.30.0/24"
    az   = "us-west-2c"
  }
}

tags = {
  Environment = "prod"
  Project     = "zero-touch"
  Region      = "us-west-2"
  CostCenter  = "Production"
  Owner       = "DevOps-Team"
  CreatedBy   = "Terraform"
}
