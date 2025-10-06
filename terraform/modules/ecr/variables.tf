variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "MUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Scan images for vulnerabilities when pushed"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Encryption type for images"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Encryption type must be AES256 or KMS."
  }
}

variable "max_image_count" {
  description = "Maximum number of images to keep in repository"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to ECR repository"
  type        = map(string)
  default     = {}
}
