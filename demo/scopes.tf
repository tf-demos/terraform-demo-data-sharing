# project, workspaces
#######################
#     Demo Project    #
#######################
resource "tfe_project" "demo_project" {
  organization = var.org-name
  name         = "${var.customer} Demos"
  description  = "Demo project for ${var.customer}"
}

#######################
#  Producer workspace #
#######################

resource "tfe_workspace" "producer" {
  name         = "${lower(var.customer)}-demo-networking"
  organization = var.org-name
  project_id   = tfe_project.demo_project.id
  auto_apply   = true
  tags = {
    env  = "demo"
    team = data.tfe_team.admin.name
  }
  vcs_repo {
    identifier     = github_repository.networking.full_name
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }

  depends_on = [github_repository_file.all_networking]
}

resource "tfe_workspace_settings" "settings" {
  workspace_id              = tfe_workspace.producer.id
  remote_state_consumer_ids = [ tfe_workspace.consumer.id ]
}

#######################
#  Consumer workspace #
#######################

resource "tfe_workspace" "consumer" {
  name         = "${lower(var.customer)}-demo-compute"
  organization = var.org-name
  project_id   = tfe_project.demo_project.id
  auto_apply   = true
  tags = {
    env  = "demo"
    team = tfe_team.demo_team.name
  }
  vcs_repo {
    identifier     = github_repository.compute.full_name
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }

  depends_on = [github_repository_file.all_compute]
}

########################
#  Consumer2 workspace #
########################

resource "tfe_workspace" "consumer2" {
  name         = "${lower(var.customer)}-demo-compute-noshare"
  organization = var.org-name
  project_id   = tfe_project.demo_project.id
  auto_apply   = true
  tags = {
    env  = "demo"
    team = tfe_team.demo_team.name
  }
  vcs_repo {
    identifier     = github_repository.compute.full_name
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }

  depends_on = [github_repository_file.all_compute]
}