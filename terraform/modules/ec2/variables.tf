variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "key_name" {
  description = "AWS Key Pair name for SSH access"
  type        = string
}

variable "create_bastion" {
  description = "Whether to create bastion host"
  type        = bool
  default     = true
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "bastion_security_group_ids" {
  description = "Security Group IDs for bastion host"
  type        = list(string)
}

variable "app_server_count" {
  description = "Number of application servers"
  type        = number
  default     = 2
}

variable "app_instance_type" {
  description = "Instance type for app servers"
  type        = string
  default     = "t3.small"
}

variable "app_security_group_ids" {
  description = "Security Group IDs for app servers"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
