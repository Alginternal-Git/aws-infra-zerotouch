variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable bucket versioning"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Block all public access"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Encryption algorithm"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "KMS key ID"
  type        = string
  default     = null
}

variable "lifecycle_enabled" {
  description = "Enable lifecycle management"
  type        = bool
  default     = true
}

variable "expiration_days" {
  description = "Object expiration days"
  type        = number
  default     = 365
}

variable "noncurrent_version_expiration_days" {
  description = "Noncurrent version expiration days"
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
