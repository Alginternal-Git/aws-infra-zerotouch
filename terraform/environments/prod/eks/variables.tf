# =============================================================================
# PRODUCTION EKS - VARIABLES
# =============================================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "prod-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
  default     = "prod-node-group"
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "user_instance_type" {
  description = "Instance type for user workloads"
  type        = string
  default     = "t3.small"
}

variable "app_instance_type" {
  description = "Instance type for app workloads"
  type        = string
  default     = "t3.medium"
}

variable "tags" {
  description = "Tags applied to all EKS resources"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "zero-touch"
    ManagedBy   = "terraform"
    Compliance  = "SOX"
    Owner       = "production-team"
  }
}
