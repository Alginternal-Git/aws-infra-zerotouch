variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "prod"
}

variable "key_name" {
  default = "prod-keypair"
}

variable "tags" {
  default = {
    Environment = "prod"
    Project     = "zero-touch"
    Owner       = "DevOps-Team"
    CreatedBy   = "Terraform"
    CostCenter  = "Production"
  }
}
