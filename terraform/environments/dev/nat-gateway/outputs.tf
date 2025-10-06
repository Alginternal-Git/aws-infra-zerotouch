# =============================================================================
# DEVELOPMENT NAT GATEWAY - OUTPUTS
# =============================================================================

output "nat_gateway_ids" {
  description = "Development NAT Gateway IDs"
  value       = module.nat_gateway.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  description = "Development NAT Gateway public IPs"
  value       = module.nat_gateway.nat_gateway_public_ips
}

output "dev_nat_summary" {
  description = "Development NAT Gateway summary"
  value = {
    environment = "dev"
    vpc_id      = var.vpc_id
    region      = var.aws_region
    nat_count   = length(module.nat_gateway.nat_gateway_ids)
    public_ips  = module.nat_gateway.nat_gateway_public_ips
    cost_model  = var.single_nat_gateway ? "single-nat" : "multi-nat"
  }
}
