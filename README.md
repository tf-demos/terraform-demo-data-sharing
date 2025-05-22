# Demo: state sharing
This repo creates a collection of assets to demo resource sharing between different workspaces in HCP Terraform. 

This example uses the `aws` provider to create a security group in the `networking` (producer) workspace which will be used by an EC2 instance in the `compute` (consumer)

The [demo](./demo/) directory contains the following resources:
- A demo project (created using the `tfe` provider)
- Consumer and producer workspaces, named compute and networking respectively.
- GitHub repos for compute and networking
- Repos content inside [repos](./demo/repos/):
    - `networking`: the resources of the producer workspace.
    - `compute`: the resources of the consumer workspace.
- The [`rbac.tf`](./demo/rbac.tf) file creates a demo team and adds an already existing user (called `ricardorompar` in this example). Change this accordingly. Some permissions are also configured for this team to only have access to read the outputs from workspaces in the demo project.

## How to use this

### 0. Clone this repo and change to it
```bash
git clone 
```

### 1. Variables
- Check and change the variables in the [tfvars.example](./demo/terraform.tfvars.example) file and once you're ready create the tfvars file:

```bash
mv demo/terraform.tfvars.example demo/terraform.tfvars
```
- Check and change the variables in the [compute](./demo/repos/compute/variables.tf) repo and the [networking](./demo/repos/networking/variables.tf) repo
