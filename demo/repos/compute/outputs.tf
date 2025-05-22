output "from_tfe_output" {
  value     = data.tfe_outputs.networking.nonsensitive_values
}

output "from_terraform_remote_state" {
  value = data.terraform_remote_state.networking.outputs
}

output "from_data_aws_vpc" {
  value = data.aws_vpc.demo.id
}

output "app_url" {
  value = "http://${aws_instance.web.public_ip}"
}