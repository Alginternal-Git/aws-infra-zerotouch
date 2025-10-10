# =============================================================================
# PRODUCTION SECURITY GROUPS - CONFIGURATION VALUES
# =============================================================================
aws_region  = "us-west-2"
environment = "prod"

# -----------------------------------------------------------------------------
# Web Access Configuration
# -----------------------------------------------------------------------------
# Allow HTTP/HTTPS access from the internet for public-facing apps
# Later, you can restrict this to your ALB or WAF CIDR blocks.
web_ingress_cidrs = ["0.0.0.0/0"]

# -----------------------------------------------------------------------------
# SSH Access Configuration
# -----------------------------------------------------------------------------
# Allow SSH temporarily from anywhere for setup.
# ⚠️ IMPORTANT: Replace "0.0.0.0/0" with your real public IP in production.
ssh_ingress_cidrs = ["0.0.0.0/0"]

# -----------------------------------------------------------------------------
# Database Access Configuration
# -----------------------------------------------------------------------------
# Allow DB access from private VPC CIDRs only (secure internal traffic)
database_ingress_cidrs = ["10.1.0.0/16"]
database_source_sgs    = []

# -----------------------------------------------------------------------------
# EKS Configuration (optional)
# -----------------------------------------------------------------------------
# Leave empty if not using EKS or will auto-populate later
eks_control_plane_sgs = []

# -----------------------------------------------------------------------------
# Optional Security Groups
# -----------------------------------------------------------------------------
# Enable bastion and app SGs for controlled SSH and app layer access
create_bastion_sg      = true
create_app_sg          = true
bastion_allowed_cidrs  = ["0.0.0.0/0"]     # ← Temporarily open; restrict later
app_ports              = [8080, 3000, 8000] # Common app/service ports

# -----------------------------------------------------------------------------
# Production Tags
# -----------------------------------------------------------------------------
tags = {
  Environment        = "prod"
  Project            = "zero-touch"
  Region             = "us-west-2"
  Service            = "security-groups"
  CostCenter         = "Production"
  Owner              = "DevOps-Team"
  Compliance         = "Enabled"
  Backup             = "Daily"
  Monitoring         = "Enhanced"
  HighAvailability   = "True"
  SecurityReview     = "Approved"
  CreatedBy          = "Terraform"
}
