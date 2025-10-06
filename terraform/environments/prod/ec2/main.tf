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
  
  default_tags {
    tags = var.common_tags
  }
}

module "ec2" {
  source = "../../../modules/ec2"

  environment                = var.environment
  vpc_id                     = var.vpc_id
  key_name                   = var.key_name
  create_bastion             = true
  bastion_instance_type      = var.bastion_instance_type
  bastion_security_group_ids = [var.bastion_sg_id]
  app_server_count           = var.app_server_count
  app_instance_type          = var.app_instance_type
  app_security_group_ids     = [var.app_sg_id]
  tags                       = var.resource_tags
}
