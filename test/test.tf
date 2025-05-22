# For this test to be successful, log in with a different token than the one with permissions
# This will throw an error since I don't have access to see the state of workspaces within that org.

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
# Uncomment this or the other to see the different errors
# data "terraform_remote_state" "networking" {
#   backend = "remote"
#   config = {
#     organization = var.org-name
#     workspaces = {
#       name = "${lower(var.customer)}-demo-networking"
#     }
#   }
# }
#
# output "test" {
#   value = data.terraform_remote_state.networking.outputs
# }

data "tfe_outputs" "networking" {
  organization = var.org-name
  workspace    = "${lower(var.customer)}-demo-networking"
}

output "from_tfe_output" {
  value     = data.tfe_outputs.networking.nonsensitive_values
}