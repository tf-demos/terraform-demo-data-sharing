# Demo: state sharing
This repo creates a collection of assets to demo resource sharing between different workspaces in HCP Terraform. 

This example uses the `aws` provider to create a security group in the `networking` (producer) workspace which will be used by an EC2 instance in the `compute` (consumer).

The [`demo`](./demo/) directory contains the following resources:
- A demo project (created using the `tfe` provider)
- Consumer and producer workspaces, named compute and networking respectively.
- GitHub repos for compute and networking
- Repos content inside [`repos`](./demo/repos/):
    - `networking`: the resources of the producer workspace.
    - `compute`: the resources of the consumer workspace.
- The [`rbac.tf`](./demo/rbac.tf) file creates a demo team and adds an already existing user (called `ricardorompar` in this example). Change this accordingly. Some permissions are also configured for this team to only have access to read the outputs from workspaces in the demo project.

## How to use this

### 1. Clone this repo and change to it
```bash
git clone https://github.com/tf-demos/terraform-demo-data-sharing.git && cd terraform-demo-data-sharing
```

### 2. Variables
- Check and change the variables in the [tfvars.example](./demo/terraform.tfvars.example) file and once you're ready create the tfvars file:

```bash
mv demo/terraform.tfvars.example demo/terraform.tfvars
```
- Check and change the variables in the [compute](./demo/repos/compute/variables.tf) repo and the [networking](./demo/repos/networking/variables.tf) repo

### 3. Authentication
**GitHub** - This repo uses the `github` provider to create example repositories in your GitHub organization. The easiest (and probably safest) way to authenticate to GitHub in the CLI is using the `gh` CLI. More info [here](https://cli.github.com/manual/gh_auth_login).

**HCP Terraform** - To use the `tfe` provider you will also need to be logged in to HCP Terraform (where the project, workspaces and team will be created). Use `terraform login` and provide a valid token. See [more](https://developer.hashicorp.com/terraform/cli/commands/login).

**AWS** - To deploy the resources from HCP Terraform to AWS you'll need the required credentials configured in HCP Terraform. The best way to accomplish this is by creating a variable set and making it available to the workspaces created in this demo configuration.

### 4. Apply
Inside the [`demo`](./demo/) directory run:

```bash
cd demo

terraform init

terraform apply #interactively confirm the apply or change it for terraform apply -auto-approve
```

### 5. Cleanup

From HCP Terraform, destroy the resources inside of the demo workspaces compute and networking and then destroy this infrastructure:

```bash
terraform destroy #interactively confirm the apply or change it for terraform destroy -auto-approve
```



