output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

output "all_subnet_ids" {
  description = "All subnet IDs"
  value       = module.subnets.all_subnet_ids
}
