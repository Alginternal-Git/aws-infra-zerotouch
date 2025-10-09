variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where instances are deployed"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "bastion_security_group_ids" {
  description = "Security groups for bastion host"
  type        = list(string)
}

variable "app_security_group_ids" {
  description = "Security groups for app servers"
  type        = list(string)
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_instance_type" {
  type    = string
  default = "t3.small"
}

variable "app_server_count" {
  type    = number
  default = 2
}

variable "create_bastion" {
  type    = bool
  default = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}
