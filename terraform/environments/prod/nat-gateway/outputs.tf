# =============================================================================
# PRODUCTION NAT GATEWAY - OUTPUTS (ENTERPRISE GRADE)
# =============================================================================

# NAT Gateway IDs
output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs created in production"
  value       = module.nat_gateway.nat_gateway_ids
}

# NAT Gateway Public IPs
output "nat_gateway_public_ips" {
  description = "List of Elastic IPs associated with NAT Gateways"
  value       = module.nat_gateway.nat_gateway_public_ips
}

# Private Route Table IDs
#output "private_route_table_ids" {
  #description = "IDs of private route tables associated with NAT Gateways"
 #value       = module.nat_gateway.private_route_table_ids
#}

# NAT Gateway Summary
output "prod_nat_summary" {
  description = "Comprehensive summary of production NAT Gateways"
  value = {
    environment         = var.environment
    vpc_id              = data.aws_vpc.selected.id
    igw_id              = data.aws_internet_gateway.selected.id
    region              = var.aws_region
    nat_count           = length(module.nat_gateway.nat_gateway_ids)
    public_ips          = module.nat_gateway.nat_gateway_public_ips
    high_availability   = true
    compliance_level    = "SOX"
    cost_model          = "multi-az-enterprise"
    redundancy_level    = "zone-level"
  }
}

# Production Connectivity Overview
output "prod_connectivity_overview" {
  description = "Network connectivity and redundancy overview for production environment"
  value = {
    outbound_internet_access = "enabled"
    high_availability        = "multi-az"
    redundancy_level         = "zone-level"
    estimated_monthly_cost   = "135–180 USD (approx)"
  }
}
