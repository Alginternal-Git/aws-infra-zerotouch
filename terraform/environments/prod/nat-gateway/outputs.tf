# =============================================================================
# PRODUCTION NAT GATEWAY - OUTPUTS (ENTERPRISE GRADE)
# =============================================================================

output "nat_gateway_ids" {
  description = "Production NAT Gateway IDs"
  value       = module.nat_gateway.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  description = "Production NAT Gateway public IPs"
  value       = module.nat_gateway.nat_gateway_public_ips
}

output "elastic_ip_ids" {
  description = "Production Elastic IP IDs"
  value       = module.nat_gateway.elastic_ip_ids
}

output "private_route_table_ids" {
  description = "Production private route table IDs"
  value       = module.nat_gateway.private_route_table_ids
}

output "prod_nat_summary" {
  description = "Comprehensive production NAT Gateway summary"
  value = {
    environment          = "prod"
    vpc_id              = var.vpc_id
    region              = var.aws_region
    nat_count           = length(module.nat_gateway.nat_gateway_ids)
    public_ips          = module.nat_gateway.nat_gateway_public_ips
    high_availability   = !var.single_nat_gateway
    cost_model          = var.single_nat_gateway ? "single-nat" : "multi-az-enterprise"
    compliance_level    = "SOX"
    support_tier        = "24x7"
    availability_zones  = length(module.nat_gateway.nat_gateway_ids)
  }
}

# Detailed NAT Gateway information for monitoring and operations
output "nat_gateway_details" {
  description = "Detailed NAT Gateway information for production monitoring"
  value       = module.nat_gateway.nat_gateway_details
}

# Production connectivity information
output "production_connectivity" {
  description = "Production connectivity summary for documentation"
  value = {
    outbound_internet_access = "enabled"
    high_availability       = "multi-az"
    redundancy_level        = "zone-level"
    estimated_monthly_cost  = "135-180-USD"  # 3 NAT Gateways * $45-60 each
    data_transfer_pricing   = "per-gb-processed"
  }
}
