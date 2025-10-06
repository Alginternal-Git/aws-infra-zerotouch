# =============================================================================
# NAT GATEWAY MODULE - OUTPUTS (UPDATED)
# =============================================================================

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_public_ips" {
  description = "List of public IPs of the NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "elastic_ip_ids" {
  description = "List of Elastic IP IDs"
  value       = aws_eip.nat[*].id
}

output "existing_route_table_ids" {
  description = "List of existing private route table IDs that were updated"
  value       = data.aws_route_tables.existing_private.ids
}

output "nat_gateway_details" {
  description = "Detailed information about NAT Gateways"
  value = {
    for i, nat in aws_nat_gateway.main : "nat-${i + 1}" => {
      id        = nat.id
      public_ip = aws_eip.nat[i].public_ip
      subnet_id = nat.subnet_id
      vpc_id    = var.vpc_id
    }
  }
}
