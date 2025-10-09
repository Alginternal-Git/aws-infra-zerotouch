# =============================================================================
# DEVELOPMENT SECURITY GROUPS - CONFIGURATION VALUES
# =============================================================================
aws_region  = "us-east-1"
environment = "dev"

# -----------------------------------------------------------------------------
# Web Access Configuration
# -----------------------------------------------------------------------------
# Allow HTTP/HTTPS access from anywhere (safe for dev only)
web_ingress_cidrs = ["0.0.0.0/0"]

# -----------------------------------------------------------------------------
# SSH Access Configuration
# -----------------------------------------------------------------------------
# Allow SSH from anywhere (more permissive for dev testing)
# In production, restrict this to office or bastion IPs.
ssh_ingress_cidrs = ["0.0.0.0/0"]

# -----------------------------------------------------------------------------
# Database Access Configuration
# -----------------------------------------------------------------------------
# Allow DB access only from within the VPC (safe for dev)
database_ingress_cidrs = ["10.0.0.0/16"]

# No specific source SGs defined (optional)
database_source_sgs = []

# -----------------------------------------------------------------------------
# EKS Configuration (optional)
# -----------------------------------------------------------------------------
eks_control_plane_sgs = []

# -----------------------------------------------------------------------------
# Optional Security Groups
# -----------------------------------------------------------------------------
create_bastion_sg = true
create_app_sg     = true
bastion_allowed_cidrs = ["0.0.0.0/0"]
app_ports             = [8080, 3000, 8000]

# -----------------------------------------------------------------------------
# Development Tags
# -----------------------------------------------------------------------------
tags = {
  Environment   = "dev"
  Project       = "zero-touch"
  Region        = "us-east-1"
  Service       = "security-groups"
  CostCenter    = "Development"
  Owner         = "DevOps-Team"
  AutoShutdown  = "Enabled"
  Backup        = "NotRequired"
  Monitoring    = "Basic"
  Purpose       = "Testing"
  CreatedBy     = "Terraform"
}
