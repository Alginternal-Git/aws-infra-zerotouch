variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "prod"
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
