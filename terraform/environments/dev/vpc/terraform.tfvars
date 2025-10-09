aws_region = "us-east-1"
vpc_cidr   = "10.0.0.0/16"

environment = "dev"   # 👈Add this

tags = {
  Project   = "aws-zero-touch"
  Owner     = "DevOps-Team"
  CreatedBy = "Terraform"
  ManagedBy = "Zero-Touch-Infrastructure"
}
