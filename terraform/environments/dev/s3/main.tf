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

module "s3" {
  source = "../../../modules/s3"
  
  bucket_name                         = var.bucket_name
  versioning_enabled                  = var.versioning_enabled
  block_public_access                 = var.block_public_access
  encryption_algorithm                = var.encryption_algorithm
  kms_key_id                         = var.kms_key_id
  lifecycle_enabled                   = var.lifecycle_enabled
  expiration_days                     = var.expiration_days
  noncurrent_version_expiration_days  = var.noncurrent_version_expiration_days
  
  tags = var.tags
}
