variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "dev-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "node_group_name" {
  description = "EKS node group name"
  type        = string
  default     = "dev-node-group"
}

variable "instance_type" {
  description = "EKS worker node type"
  type        = string
  default     = "t3.small"
}

variable "desired_capacity" {
  description = "Desired node count"
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Min node count"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Max node count"
  type        = number
  default     = 3
}

variable "user_instance_type" {
  description = "Instance type for user workloads"
  type        = string
  default     = "t3.micro"
}

variable "app_instance_type" {
  description = "Instance type for app workloads"
  type        = string
  default     = "t3.small"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
  }
}
