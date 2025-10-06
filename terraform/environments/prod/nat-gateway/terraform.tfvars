# =============================================================================
# PRODUCTION NAT GATEWAY - CONFIGURATION VALUES (ENTERPRISE GRADE)
# =============================================================================

# AWS Configuration
aws_region = "us-west-2"
environment = "prod"

# Network Configuration - YOUR ACTUAL PRODUCTION VPC
vpc_id = "vpc-094620e7f146a180b"  # Your prod-vpc from screenshots

# Production High Availability - Multiple NAT Gateways
single_nat_gateway = false  # Multi-AZ for high availability

# Production Enterprise Tags (SOX Compliance)
tags = {
  Environment            = "prod"
  Project               = "zero-touch"
  ManagedBy             = "terraform"
  
  # Compliance & Security
  Compliance            = "SOX"
  DataClassification    = "Internal"
  SecurityReview        = "Approved"
  
  # Operations & Support
  Support               = "24x7"
  Criticality           = "High"
  MonitoringRequired    = "Yes"
  BackupRequired        = "Yes"
  
  # High Availability
  HighAvailability      = "Multi-AZ"
  DisasterRecovery      = "Required"
  
  # Financial
  CostCenter            = "production"
  BusinessUnit          = "engineering"
  Owner                 = "production-team"
  
  # Governance & Maintenance
  CreatedDate           = "2025-09-29"
  ReviewDate            = "2026-09-29"
  ApprovedBy            = "infrastructure-team"
  MaintenanceWindow     = "Sunday-02:00-04:00-PST"
  
  # Network
  VPC                   = "prod-vpc"
  Region                = "us-west-2"
  NATType               = "multi-az-enterprise"
}
