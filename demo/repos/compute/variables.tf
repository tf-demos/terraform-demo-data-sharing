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

variable "org-name" {
  description = "Name for the (preexisting) organization to create modules in."
  type        = string
  default     = "r2-org" #Change this to your org name
}

variable "customer" {
  description = "Customer name."
  type        = string
  default     = "SAP"
}