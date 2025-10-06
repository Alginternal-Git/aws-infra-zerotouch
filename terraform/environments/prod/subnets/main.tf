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

module "subnets" {
  source = "../../../modules/subnets"
  
  environment           = var.environment
  vpc_id               = var.vpc_id
  create_public_subnets = var.create_public_subnets
  internet_gateway_id   = var.internet_gateway_id
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  tags                 = var.tags
}
