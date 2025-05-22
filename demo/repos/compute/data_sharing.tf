data "tfe_outputs" "networking" {
  organization = var.org-name
  workspace    = "${lower(var.customer)}-demo-networking"
}

data "terraform_remote_state" "networking" {
  backend = "remote"
  config = {
    organization = var.org-name
    workspaces = {
      name = "${lower(var.customer)}-demo-networking"
    }
  }
}

data "aws_vpc" "demo" {
  tags = {
    Name = "${var.prefix}-demo-vpc"
  }
}