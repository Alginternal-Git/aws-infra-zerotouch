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
  default = 1
}
variable "max_capacity" {
  type    = number
  default = 3
}
variable "eks_role_arn" {}
variable "node_role_arn" {}
variable "cluster_version" {
  type    = string
  default = "1.32"   # default value optional
}
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "zero-touch"
  }
}
variable "user_instance_type" {
  type    = string
  default = "t3.medium"
}
variable "app_instance_type" {
  type    = string
  default = "t3.medium"
}
