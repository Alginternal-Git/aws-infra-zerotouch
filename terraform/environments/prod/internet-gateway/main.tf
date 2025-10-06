terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "internet_gateway" {
  source = "../../../modules/internet-gateway"
  
  environment = var.environment
  vpc_id      = var.vpc_id
  tags        = var.tags
}
