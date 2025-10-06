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

module "key_pair" {
  source                = "../../../modules/key-pair"
  environment           = var.environment
  name              = var.key_name
  key_save_path         = "./keys/${var.environment}"
  store_private_key_ssm = true
  tags                  = var.resource_tags
}
