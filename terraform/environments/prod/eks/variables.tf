variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "node_group_name" {}
variable "instance_type" {}
variable "desired_capacity" {
  type = number
}
variable "min_capacity" {
  type    = number
  default = 2
}
variable "max_capacity" {
  type    = number
  default = 10
}
variable "eks_role_arn" {}
variable "node_role_arn" {}
variable "cluster_version" {
  type    = string
  default = "1.32"
}
variable "tags" {
  type = map(string)
  default = {
    Environment = "prod"
    Project     = "zero-touch"
    Region      = "us-west-2"
  }
}
variable "user_instance_type" {
  type    = string
  default = "t3.large"
}
variable "app_instance_type" {
  type    = string
  default = "t3.large"
}
