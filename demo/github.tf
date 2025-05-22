locals {
  # the path to where the repository content is
  path_networking = "${path.module}/repos/networking"
  path_compute    = "${path.module}/repos/compute"

  # get all filenames in the content directory
  # instead of "**" representing all files and subdirectories you can use a pattern to get certain files
  filenames_networking = fileset(local.path_networking, "**")
  filenames_compute    = fileset(local.path_compute, "**")

  # create a map (filename => content)
  content_networking = { for filename in local.filenames_networking : filename => file("${local.path_networking}/${filename}") }
  content_compute    = { for filename in local.filenames_compute : filename => file("${local.path_compute}/${filename}") }
}


###  NETWORKING REPO  ###
resource "github_repository" "networking" {
  name = "demo-networking"
}

resource "github_repository_file" "all_networking" {
  for_each = local.content_networking

  repository = github_repository.networking.name
  file       = each.key
  content    = each.value
}

###  COMPUTE REPO  ###
resource "github_repository" "compute" {
  name = "demo-compute"
}

resource "github_repository_file" "all_compute" {
  for_each = local.content_compute

  repository = github_repository.compute.name
  file       = each.key
  content    = each.value
}

###  GITHUB OAUTH  ###
# For this to work you need to have a GitHub OAuth token with the right permissions already set up in your HCP Terraform organization
data "tfe_oauth_client" "client" {
  organization     = var.org-name
  name             = var.oauth_client_name
  service_provider = "github"
}