output "vpc_id" {
  description = "Development VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Development VPC CIDR block"
  value       = module.vpc.vpc_cidr
}
