variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "name" {
  description = "Key pair name base"
  type        = string
}

variable "key_save_path" {
  description = "Local path to save private key file"
  type        = string
  default     = "./"
}

variable "store_private_key_ssm" {
  description = "Whether to store private key in AWS SSM Parameter Store"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}
