variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}