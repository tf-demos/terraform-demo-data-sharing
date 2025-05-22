terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.65.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
}

provider "github" {
  owner = var.github_organization
}
