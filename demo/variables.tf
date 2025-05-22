variable "org-name" {
  description = "Name for the (preexisting) organization to create modules in."
  type        = string
}

variable "customer" {
  description = "Customer name."
  type        = string
}

variable "github_organization" {
  description = "GitHub organization name."
  type        = string
  default     = "tf-demos"
}

variable "oauth_client_name" {
  description = "Name of the OAuth client configured in HCP Terraform"
  type        = string
}