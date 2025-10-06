terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"  # match 6.x
    }
  }
}

provider "aws" {
  region  = "us-west-1"
  profile = "default"
}
