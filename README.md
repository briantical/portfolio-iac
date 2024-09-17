# PORTOFIO IAC

This repository describe the infrastructure, using Terraform, that runs my portfolio site.

## Setups to run

Add the digital ocean personal access token to the environment variables using `DIGITALOCEAN_TOKEN`. This also needs to be configured in the terraform cloud variables.

Install terraform version `1.4.6` on you local device to view the planned changes.

1. `terraform login`
2. `terraform -chdir=Terraform/ init`
3. `terraform -chdir=Terraform/ plan`

The infrastructure changes are applied when there is a push to master.
