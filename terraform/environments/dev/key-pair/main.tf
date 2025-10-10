provider "aws" {
  region = var.aws_region
}

module "key_pair" {
  source      = "../../../modules/keypair"
  environment = var.environment
  aws_region  = var.aws_region
  key_name    = "${var.environment}-keypair"
  tags        = var.tags
}
