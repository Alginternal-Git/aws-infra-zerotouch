# ------------------------------------------------------
#  Environment & Region Settings
# ------------------------------------------------------
aws_region  = "us-east-1"
environment = "dev"

# ------------------------------------------------------
# EC2 Configuration
# ------------------------------------------------------
bastion_instance_type = "t3.micro"
app_instance_type     = "t3.small"
app_server_count      = 1 # Set to >0 to launch app servers

# ------------------------------------------------------
# Tagging (Common + Resource Specific)
# ------------------------------------------------------
common_tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "dev-team"
}

resource_tags = {
  CostCenter = "development"
  Backup     = "daily"
}

# ------------------------------------------------------
# Removed hardcoded IDs
# ------------------------------------------------------
# vpc_id                = "vpc-0f13f9687b72a6e03"
#  bastion_sg_id         = "sg-06ea97586cd"
#  app_sg_id             = "sg-028ca1b0d612"
#
# ✅ These IDs are now dynamically fetched via data blocks in main.tf:
#   - data "aws_vpc" "selected"         → gets VPC by tag/name
#   - data "aws_security_group" "bastion" → gets bastion SG by tag/name
#   - data "aws_security_group" "app"     → gets app SG by tag/name
#  key_name                   = data.aws_key_pair.existing.key_name
# ✅ Benefit: No need to manually update IDs across environments.
#             Just tag resources properly and Terraform finds them automatically.
