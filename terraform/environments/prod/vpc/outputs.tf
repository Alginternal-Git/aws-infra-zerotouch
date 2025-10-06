output "vpc_id" {
  description = "Production VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Production VPC CIDR block"
  value       = module.vpc.vpc_cidr
}
