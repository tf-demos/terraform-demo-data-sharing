# team - permissions, users

#######################
#        Teams        #
#######################
# Get admin team
data "tfe_team" "admin" {
  name         = "owners"
  organization = var.org-name
}

resource "tfe_team_project_access" "admin" {
  access     = "admin"
  team_id    = data.tfe_team.admin.id #my already existing team
  project_id = tfe_project.demo_project.id
}

# Create new team with read access to demo project
resource "tfe_team" "demo_team" {
  name         = "compute"
  organization = var.org-name
}

resource "tfe_team_project_access" "demo" {
  access     = "custom"
  team_id    = resource.tfe_team.demo_team.id
  project_id = tfe_project.demo_project.id

  project_access {
    settings = "read"
    teams    = "read"
  }
  workspace_access {
    runs           = "apply"
    state_versions = "read-outputs" #THIS will give this team read access to the outputs only
    variables      = "write"
    locking        = true
  }
}

# Add a user to the demo team
resource "tfe_team_member" "demo_user" {
  team_id  = tfe_team.demo_team.id
  username = "ricardorompar" #User should be already member of the organization
}

