variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "key_name" {
  default = "dev-keypair"
}

variable "tags" {
  default = {
    Environment = "dev"
    Project     = "zero-touch"
    Owner       = "DevOps-Team"
    CreatedBy   = "Terraform"
    CostCenter  = "Development"
  }
}
