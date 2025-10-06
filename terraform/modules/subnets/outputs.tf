output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = var.create_public_subnets ? aws_route_table.public[0].id : null
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}

output "all_subnet_ids" {
  description = "All subnet IDs"
  value = merge(
    { for k, v in aws_subnet.public : k => v.id },
    { for k, v in aws_subnet.private : k => v.id }
  )
}
