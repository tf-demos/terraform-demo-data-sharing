variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "hashicardo"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "port" {
  type    = number
  default = 80
}