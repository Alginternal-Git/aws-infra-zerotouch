variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Scan on push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Encryption type"
  type        = string
  default     = "AES256"
}

variable "max_image_count" {
  description = "Max images to keep"
  type        = number
  default     = 50
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
