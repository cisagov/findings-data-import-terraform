# findings-data-import-terraform #

[![GitHub Build Status](https://github.com/cisagov/findings-data-import-terraform/workflows/build/badge.svg)](https://github.com/cisagov/findings-data-import-terraform/actions)

This project creates the resources used to import findings data into AWS.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- AWS CLI access
  [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
  for the appropriate account on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified [here](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified [here](backend.tf)).

## Customizing Your Environment ##

Create a terraform variables file to be used for your environment (e.g.
  `production.tfvars`), based on the variables listed in [Inputs](#inputs)
  below. Here is a sample of what that file might look like:

```hcl
aws_region = "us-east-2"

tags = {
  Team = "CISA Development Team"
  Application = "Findings Data Import"
  Workspace = "production"
}
```

## Building the Terraform-based infrastructure ##

1. Create a Terraform workspace (if you haven't already done so) by running:

   ```console
   terraform workspace new <workspace_name>`
   ```

1. Create a `<workspace_name>.tfvars` file with all of the required
   variables and any optional variables desired (see [Inputs](#inputs) below
   for details).
1. Run the command `terraform init`.
1. Create the Terraform infrastructure by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars
   ```

## Tearing down the Terraform-based infrastructure ##

1. Select the appropriate Terraform workspace by running
   `terraform workspace select <workspace_name>`.
1. Destroy the Terraform infrastructure in that workspace by running
   `terraform destroy -var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.75 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.75 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_access_key.exported_data_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.exported_data_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.exported_data_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_s3_bucket.exported_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.exported_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.exported_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.exported_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.exported_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.exported_data_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.exported_data_write_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| findings\_data\_bucket\_access\_role\_arn | The ARN of the IAM role that is allowed to access the S3 bucket containing the findings data. | `string` | `""` | no |
| findings\_data\_bucket\_object\_key\_pattern | The key pattern specifying which objects are allowed to be written to the findings data S3 bucket. | `string` | `"*-data.json"` | no |
| findings\_data\_s3\_bucket | The name of the bucket where the findings data JSON file will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace\_name>' will be appended to the bucket name. | `string` | `"findings-data"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

No outputs.

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
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
