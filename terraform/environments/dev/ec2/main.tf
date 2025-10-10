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

# -----------------------------------------------------------------------------
# FETCH EXISTING VPC, SUBNETS, SECURITY GROUPS
# -----------------------------------------------------------------------------
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

# Dynamic SG lookups
data "aws_security_group" "bastion" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-bastion-sg"]
  }
  vpc_id = data.aws_vpc.selected.id
}

data "aws_security_group" "app_servers" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-app-servers-sg"]
  }
  vpc_id = data.aws_vpc.selected.id
}
# ----------------------------------------------------------------------------- 
# FETCH EXISTING KEY PAIR CREATED BY KEY-PAIR MODULE 
# -----------------------------------------------------------------------------
data "aws_key_pair" "existing" {
  key_name = "${var.environment}-key-pair"
}

# -----------------------------------------------------------------------------
# MODULE CALL - EC2
# -----------------------------------------------------------------------------
module "ec2" {
  source = "../../../modules/ec2"

  environment                = var.environment
  vpc_id                     = data.aws_vpc.selected.id
  key_name                   = data.aws_key_pair.existing.key_name
  public_subnet_ids          = data.aws_subnets.public.ids
  private_subnet_ids         = data.aws_subnets.private.ids
  bastion_security_group_ids = [data.aws_security_group.bastion.id]
  app_security_group_ids     = [data.aws_security_group.app_servers.id]
  tags                       = var.tags
}
