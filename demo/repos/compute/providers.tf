terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.65.0"
    }
  }
}

provider "aws" {
  region = var.region
}