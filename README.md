# findings-data-import-terraform #

[![GitHub Build Status](https://github.com/cisagov/skeleton-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/skeleton-tf-module/actions)

This project creates the resources used to import findings data into AWS.

## Pre-requisites ##

* [AWS CLI access
  configured](
  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  on your system
* [Terraform installed](
  https://learn.hashicorp.com/terraform/getting-started/install.html)
  on your system

## Customizing Your Environment ##

Create a terraform variables file to be used for your environment (e.g.
  `production.yml`), based on the variables listed in `variables.tf`.
  Here is a sample of what that file might look like:

```yaml
aws_region = "us-east-1"

aws_availability_zone = "a"

tags = {
  Team = "CISA Development Team"
  Application = "Findings Data Import"
  Workspace = "production"
}
```

## Building the Terraform-based infrastructure ##

The Terraform-based infrastructure is built like so:

```console
terraform init

# If you have not created your terraform workspace:
terraform workspace new <your_workspace>

# If you have previously created your terraform workspace:
terraform workspace select <your_workspace>

terraform apply -var-file=<your_workspace>.yml
```

## Tearing down the Terraform-based infrastructure ##

The Terraform-based infrastructure is torn down like so:

```console
terraform workspace select <your_workspace>
terraform destroy -var-file=<your_workspace>.yml
```

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_availability_zone | The AWS availability zone to deploy into (e.g. a, b, c, etc.) | `string` | `a` | no |
| aws_region | The AWS region to deploy into (e.g. us-east-1) | `string` | `us-east-1` | no |
| findings_data_import_lambda_s3_bucket | The name of the bucket where the findings data import lambda function will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name. | `string` | `findings-data-import-lambda` | no |
| findings_data_s3_bucket | The name of the bucket where the findings data JSON file will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name. | `string` | `findings-data` | no |
| tags | Tags to apply to all AWS resources created | `map(string)` | `{}` | no |

## Outputs ##

No output.

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
