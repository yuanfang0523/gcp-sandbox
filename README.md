# Terraform Repo Template

Terraform is used to manage infrastructure resources for GCP.

## Usage

To create a new Terraform repo, Add a new repo in GitHub, and select `terraform-template`
as the template.  Please wait for a few minutes before clone and start to work on the new
repo.  This template includes a GitHub action workflow to customize the new repo.

After the repo is created, remove unneeded workspace `tfvars` files under
`terraform/tfvars` and corresponding workflow in `atlantis.yaml`.  See
[section bellow](#terraform-workspace-and-atlantis-workflow).

### Repo Naming Convention

A Terraform repo should be named after the service that the resources in the repo is
for.  For example, for GCP resources used for `k8s`, the Terraform repo is named
to `k8s-tf`.

The intialization GitHub action workflow will customize a few things in the repo based
on the repo name.  These include:

- Terraform state file prefix in GS bucket: `<REPO_NAME>`
- Service tag on the resources: <REPO_NAME> without the `-tf` postfix
- Owner: owner of the repo

### Terraform Workspace

We use different Terraform workspaces for resources in different GCP project. Each workspace
has a corresponding Atlantis workflow with the same name.  This enables
Atlantis to plan and apply changes in the workspace.  Each workspace also has a `tfvars`
under `terraform/tfvars` directory to customize settings for the workspace.  For example,
`prod` and `test` workspace resources are in different GCP project, and may use different
VPC.

A Terraform repo may not create resources in all workspaces.  For example, the
[CICD repo](https://github.com/picktrace/cicd_tf) manages resources used for the CI/CD platform,
and only in the `picktrace-platform` project and `plat` workspace.

Besides these workspaces for actually resource deployment, local workspaces for
Terraform development is also supported.  A template `tfvars` file,
`terraform/tfvars/local.tfvars.local.tmpl`, is provided, which can be used to
create workspaces for developers.

## Repo Structure

This template creates these components for an initial Terraform repo:

##### Version File

`/.terraform-version`

This file at the root of the repo has a single line indicating the required version
of Terraform for `tfenv`.  If you have `tfenv` installed locally, it should handle version
selection and ensure that your local run is using the proper version.

##### Atlantis Configuration

`/atlantis.yaml`

This file configures Atlantis workflows this repo needs.  It initially has all supported
workflows.  A repo maintainer should remove all unneeded workflows when initially setting
up the repo.

##### `tf` Script

`/bin/tf`

This script is mostly used to ease up running Terraform locally for testing. Users may use
these simple command to initialize, create, and delete testing resources in the
`picktrace-sandbox` GCP project:

- `./bin/tf init`
- `./bin/tf update`
- `./bin/tf destroy`

In addition, the script also provide a command to update provider lock file if a new provider
is added, or an existing provider is updated.

- `./bin/tf lock`

##### Terraform Folder

`/terraform`

All Terraform files should go under this folder. A few boilerplates files are created by
the templated and they normally don't need to be modified by users.  These includes:

- `terraform/terraform.tf`: Backend and provider configurations, also lock down Terraform version
  for Atlantis
- `terraform/vars.tf`: Variable definitions.  Came with a set of standard variables, user may
  add any additional variables for things that are different between workspaces
- `terraform/tfvars/*.tfvars`: Variable configuration for different workspaces. Should only
  keep files for workspaces required by the repo.
- `terraform/tfvars/local.tfvars.local.tmpl`: Template variable configuration for local testing.
- `terraform/.terraform.lock.hcl`: Provider lock file.  Automatically generated and should not
  be updated manually.

##### Code Owner

`.github/CODEOWNERS`

All files in Terraform repos are owned by the Ops team, and require approval from a member
of the team.  This should not be changed.
