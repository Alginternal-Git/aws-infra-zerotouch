# =============================================================================
# MAIN CONFIGURATION - PROD ENVIRONMENT (KEYPAIR MODULE)
# =============================================================================
# This configuration deploys an AWS EC2 Key Pair for the production environment.
# It references the reusable keypair module from the modules directory.
# =============================================================================

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
