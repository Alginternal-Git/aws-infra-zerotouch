variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for worker nodes"
  type        = list(string)
}

variable "node_group_name" {
  description = "EKS Node Group name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_capacity" {
  description = "Max nodes for scaling"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "Min nodes for scaling"
  type        = number
  default     = 1
}

variable "eks_role_arn" {
  description = "IAM Role ARN for EKS Cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN for worker nodes"
  type        = string
}

variable "name" {
  description = "Name prefix for the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for the EKS Cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
variable "user_instance_type" {
  description = "EC2 instance type for user node group"
  type        = string
  default     = "t3.medium"  # Optional default
}

variable "app_instance_type" {
  description = "EC2 instance type for app node group"
  type        = string
  default     = "t3.medium"  # Optional default
}
