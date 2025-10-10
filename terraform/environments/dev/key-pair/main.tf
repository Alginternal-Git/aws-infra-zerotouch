provider "aws" {
  region = var.aws_region
}

module "key_pair" {
  source      = "../../../modules/key-pair"
  environment = var.environment
  aws_region  = var.aws_region
  key_name    = "${var.environment}-key-pair"
  tags        = var.tags
}
