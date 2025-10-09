aws_region  = "us-west-2"
environment = "dev"

cluster_name     = "dev"
cluster_version  = "1.30"

node_group_name  = "dev-node-group"
instance_type    = "t3.small"
desired_capacity = 1
min_capacity     = 1
max_capacity     = 2

user_instance_type = "t3.micro"
app_instance_type  = "t3.small"

tags = {
  Environment = "dev"
  Project     = "zero-touch"
  ManagedBy   = "terraform"
  Owner       = "devops-team"
}
